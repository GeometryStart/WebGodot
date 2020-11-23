tool
extends TextureButton

export (String, FILE) var next_scene_path = ""

func _on_Alusta_pressed():
	print("Alusta")
	get_tree().change_scene("res://src/Vaheleht1.tscn")

func _get_configuration_warning()-> String:
	return "Next scene path must be set to button to work" if next_scene_path == "" else ""



func _on_Alusta_mangu_button_up():
	get_tree().change_scene("res://src/Levels/Level1.tscn")


func _on_Alusta_mangu_pressed():
	pass # Replace with function body.


func _on_Mngima_pressed():
	get_tree().change_scene("res://src/Levels/Level1.tscn")


func _on_Exit_pressed():
	get_tree().quit()
