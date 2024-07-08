# define Server
server <- function(input, output, session) {

	# load table
	data_src <- reactiveVal(NULL)
	
	# load map
	data_map <- reactiveVal(NULL)

	# update characters names once the table is loaded
	observeEvent(input$load_data, {
	
		# read input table
		my_table <- req(input$char)
		# load table
		loaded_table <- read.csv(my_table$datapath, header=TRUE, sep=",")
		# update the playing characters
		updateSelectInput(session, "character", "Select character", choices=loaded_table$character)
		
		# add shape to characters
		loaded_table$shape <- rep(21, nrow(loaded_table))
		# add colours to characters
		loaded_table$colour <- rep("deeppink", nrow(loaded_table))
		
		# read input table
		my_map <- req(input$map)
		# load table
		loaded_map <- readJPEG(my_map$datapath)
		
		# return objects
		data_map(loaded_map)
		data_src(loaded_table)
		
	})
	
	# Move the selected point
	observeEvent(input$plot_click, {
	
		# Get the x and y coordinates at the click of the mouse
		char_src <- data_src()
		char_src <- data_src(move_character(char_src, input$character, x=input$plot_click$x, y=input$plot_click$y))
		
	})

	# remove character
	observeEvent(input$remove_character, {
	
		char_src <- data_src()
		char_src <- data_src(remove_character(char_src, input$character))
		# update the playing characters
		updateSelectInput(session, "character", "Select character", choices=data_src()$character)
		
	})

	# add character
	observeEvent(input$add_character, {
	
		char_src <- data_src()
		# check if a name for the new character was entered
		if (input$add_me=="") {
			# if not then the name will be set as "i am here by mistake"
			char_src <- data_src(add_character(char_src, "No name entered, remove me!"))
		} else {
			# if yes, then the name will be used
			char_src <- data_src(add_character(char_src, firstup(input$add_me)))
		}
		# update the playing characters
		updateSelectInput(session, "character", "Select character", choices=data_src()$character)
		
	})
	
	# partially hide a character
	observeEvent(input$partially_hide_character, {
	
		char_src <- data_src()
		char_src <- data_src(partially_hide(char_src, input$character))
		
	})

	# completely hide a character
	observeEvent(input$completely_hide_character, {
	
		char_src <- data_src()
		char_src <- data_src(completely_hide(char_src, input$character))
		
	})

	# un-hide a character
	observeEvent(input$un_hide_character, {
	
		char_src <- data_src()
		char_src <- data_src(un_hide(char_src, input$character))
		
	})
	
	# download current character table
	output$download <- downloadHandler(
		# create filename
		filename = function(){paste0(gsub("__", "_", gsub(" ", "_", date())), "_session_character_table.csv")},
		# export
		content = function(fname){
			write.table(data_src(), fname, quote=F, row.names=F, sep=",")
			}
	)

	# render map and characters
	output$map <- renderPlot({
	
		req(data_src())
		char_src <- data_src()
		map_src <- data_map()
		plot_map(char_src, map_src)
		
		
	}, height=800, width=800)
}
