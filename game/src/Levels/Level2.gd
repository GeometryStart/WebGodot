extends Node2D
export (PackedScene) var player
var isGreenVisible = false
onready var score: Label = get_node("CanvasLayer/Label")
onready var username: Label = get_node("CanvasLayer/LabelUser") 
func _ready():
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 2
	OS.set_window_position(centered_pos)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("user_starts", self, "_on_HTTPRequest_request_completed")
	update_interface()
	var location = GameData.player_location2
	var p = player.instance()
	add_child(p)
	p.set_position(location)
	
#	if location >= get_node("Checkpoint_red1").teleport_location and location < get_node("Checkpoint_red2").teleport_location and GameData.isCheckpointPassed == true:
#		print("Chips 1",location)
#		get_node("Checkpoint_green1").visible = true
#		get_node("Checkpoint_red1").visible = false
#		get_node("Checkpoint_red1/CollisionShape2D").set_deferred("disabled", true)
#	if location >= get_node("Checkpoint_red2").teleport_location and location <= get_node("Checkpoint_red3").teleport_location and GameData.isCheckpointPassed == true:
#		print("Chippy location2: ", location)
#		get_node("Checkpoint_green2").visible = true
#		get_node("Checkpoint_red2").visible = false
#		get_node("Checkpoint_red2/CollisionShape2D").set_deferred("disabled", true)
#	if location >= CheckpointRed3.teleport_location and location <= get_node("Checkpoint_red4").teleport_location and GameData.isCheckpointPassed == true:
#		print("Chippy location3: ", location)
#		get_node("Checkpoint_green3").visible = true
#		get_node("Checkpoint_red3").visible = false
#		get_node("Checkpoint_red3/CollisionShape2D").set_deferred("disabled", true)
#	if location >= CheckpointRed4.teleport_location and location <= get_node("Checkpoint_red5").teleport_location and GameData.isCheckpointPassed == true:
#		print("Chippy location4: ", location)
#		get_node("Checkpoint_green4").visible = true
#		get_node("Checkpoint_red4").visible = false
#		get_node("Checkpoint_red4/CollisionShape2D").set_deferred("disabled", true)
#
func update_interface() -> void:
	score.text = "Punktid: %s" % PlayerData.score
	
