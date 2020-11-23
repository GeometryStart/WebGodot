extends Node2D
 #place of the file
var save_data = ""

func save_user(data):
	var save_data = data
	var file = File.new() #file
	var location = "user://save_game.sav"
	
	print("Saving game to: " + OS.get_user_data_dir() + "Kasutaja on: " + save_data)
	if file.open(location, File.WRITE) != 0:
		print("Cannot write temporary file to: ", location)
	else:
		file.store_line(to_json(save_data))
		print("Username saved")
		file.close()
		
		
func load_save_file():
	var file = File.new()
	file.open("user://save_game.sav", file.READ)
	var text = file.get_as_text()
	print("Loetud data failist: ", text)
	save_data = text
	return save_data
	file.close()
