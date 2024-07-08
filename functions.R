# capitalise first letter for new characters
firstup <- function(char_name) {

	substr(char_name, 1, 1) <- toupper(substr(char_name, 1, 1))
	return(char_name)
}

# move character using the coordinates provided with the mouse click
move_player <- function(data_src, pname, x_pos=0, y_pos=0) {

	# modify the x and y positions in the data frame
	data_src$x_pos[which(data_src$player==pname)] <- x_pos
	data_src$y_pos[which(data_src$player==pname)] <- y_pos
	# return updated data_src
	return(data_src)
	
}

# add new character
add_character <- function(data_src, pname) {

	# add character from the dataframe
	data_src <- rbind.data.frame(cbind.data.frame(player=pname, x_pos=5, y_pos=5, shape=22, colour="firebrick1", hidden=0), data_src)
	# return updated data_src
	return(data_src)
	
}

# remove character
remove_character <- function(data_src, pname) {

	# remove character from the dataframe
	data_src <- data_src[-which(data_src$player==pname), ]
	# return updated data_src
	return(data_src)
	
}

# plot map and characters
plot_map <- function(data_src, map_img) {

	# create palette from the input table
	char_palette <- data_src$colour
	names(char_palette) <- unique(data_src$player)

	# create the plot
	the_map <- ggplot(data_src, aes(x=x_pos, y=y_pos, fill=player)) +
			# add the map as a background
			background_image(map_img) +
			# select shape and size for characters
			# a character is hidden if their value is 1.
			# the correct alpha for hidded is (1-hidden)
			geom_point(shape=21, color="black", size=6, stroke=2, alpha=(1-data_src$hidden)) +
			scale_fill_manual(values=char_palette) +
			# add characters names
			geom_text(label=data_src$player, nudge_x=-2.5, nudge_y=-2.5, size=8, fontface="bold") +
			xlab("") +
			ylab("") +
			# fix dimensions for x and y axis
			scale_x_continuous(limits=c(0, 80), breaks=seq(0, 80, by=5)) +
			scale_y_continuous(limits=c(0, 80), breaks=seq(0, 80, by=5)) +
			coord_fixed() +
			# show grid on top of the map
			theme(axis.text=element_blank(), panel.background=element_blank(), panel.ontop=TRUE, legend.position="none")
	return(the_map)
	
}

# partially hide player
partially_hide <- function(data_src, pname) {
	
	# set alpha
	data_src$hidden[which(data_src$player==pname)] <- 0.5
	return(data_src)
	
}

# completely hide player
completely_hide <- function(data_src, pname) {
	
	# set alpha
	data_src$hidden[which(data_src$player==pname)] <- 1
	return(data_src)
	
}

# un-hide player
un_hide <- function(data_src, pname) {
	
	# set alpha
	data_src$hidden[which(data_src$player==pname)] <- 0
	return(data_src)
	
}
