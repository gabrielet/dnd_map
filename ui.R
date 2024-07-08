# load libraries
library("shiny")
library("jpeg")
library("ggplot2")
library("ggpubr")
library("shinydashboard")
library("shinyWidgets")

# load functions
source("functions.R")

# define UI for shiny app
ui <- fluidPage(

	dashboardHeader(
		tags$li(class = "dropdown",
			dropMenu(
				dropdownButton("Info", status = 'success', icon = icon('info')),
				h3(strong('How to use the app')),
				br(),
				h5(paste("You will need to upload a comma-separated file containing the characters and a map in format jpg/jpeg.",
					"The comma-separated file must follow this structure (copy-paste, save, and modify it as needed):",
					"character,x_pos,y_pos,hidden",
					"character_1,10,20,0",
					"character_2,10,30,0",
					"character_3,20,20,0",
					"monster_1,40,50,0", sep="\n")),
				placement = "bottom",
				arrow = TRUE
			)
		)

	),
	dashboardSidebar(),

	sidebarPanel(
	
		# show title
		titlePanel(""),

		# file-selection input dialog to pass the table
		fileInput("char", "Select characters"),

		# file-selection input dialog to pass the table
		fileInput("map", "Select map"),

		# button to load table
		actionButton("load_data", label="Load characters and map", choices=NULL),

		# character-selection input dialog
		selectInput("character", label="Select character", choices=NULL),
		
		# add character input dialog
		textInput("add_me", label="Add character"),

		# remove-character selection input dialog
		actionButton("remove_character", label="Remove character", choiches=NULL),

		# remove-character selection input dialog
		actionButton("add_character", label="Add character", choiches=NULL),

		# partially hide character from input dialog
		actionButton("partially_hide_character", label="Partially hide character", choiches=NULL),

		# hide character from input dialog
		actionButton("completely_hide_character", label="Hide character", choiches=NULL),

		# hide character from input dialog
		actionButton("un_hide_character", label="Un-hide character", choiches=NULL),

		# dowload current table, to use it next session
		downloadButton('download',"Download characters table")

	),

	# render the map showing where the characters are located
	mainPanel(

		# moving character with mouse
		plotOutput("map", click="plot_click")

	)
)
