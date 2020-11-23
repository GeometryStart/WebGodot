extends Node2D
var timer = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1.5)
	timer.connect("timeout", self, "on_timeout")
	add_child(timer)
	timer.start()
	
func on_timeout():
	if  CheckpointRed1.isCheckpoint1:
		get_tree().change_scene("res://src/Levels/Level1.tscn")
		GameData.player_location1 = GameData.CP1_location
		GameData.isCheckpointPassed = true
		
	elif CheckpointRed2.isCheckpoint2:
		print("Checkpoint2 läbitud")
		get_tree().change_scene("res://src/Levels/Level1.tscn")
		GameData.player_location1 = GameData.CP2_location
		GameData.isCheckpointPassed = true
	elif CheckpointRed3.isCheckpoint3:
		print("Checkpoint3 läbitud")
		get_tree().change_scene("res://src/Levels/Level1.tscn")
		GameData.player_location1 = GameData.CP3_location
		GameData.isCheckpointPassed = true
	elif CheckpointRed4.isCheckpoint4:
		print("Checkpoint4 läbitud")
		get_tree().change_scene("res://src/Levels/Level1.tscn")
		GameData.player_location1 = GameData.CP4_location
		GameData.isCheckpointPassed = true
	elif CheckpointRed5.isCheckpoint5:
		print("Checkpoint5 läbitud")
		get_tree().change_scene("res://src/Levels/Level2.tscn")
		GameData.player_location1 = Vector2(142.066, 699.882)
		GameData.isCheckpointPassed = true
		


func _on_ExitGame_button_up():
	get_tree().quit()
