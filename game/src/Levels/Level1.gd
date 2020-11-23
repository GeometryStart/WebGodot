extends Node2D
export (PackedScene) var player
var isGreenVisible = false

var my_url= "https://digiseiklus.digikapp.ee/digiseiklus/scores.json"
onready var score: Label = get_node("CanvasLayer/Label")
onready var usernameL: Label = get_node("CanvasLayer/userLabel")


func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request(my_url)
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 2.5
	OS.set_window_position(centered_pos)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	PlayerData.connect("score_updated", self, "update_interface")
	
	update_interface()
	var audioPlayer = AudioStreamPlayer.new()
	self.add_child(audioPlayer)
	audioPlayer.stream = load("res://assets/helid/taust3.wav")
	audioPlayer.stop()
	
	var location = GameData.player_location1
	var p = player.instance()
	add_child(p)
	p.set_position(location)
	

	if location >= GameData.CP1_location and location < GameData.CP2_location and GameData.isCheckpointPassed == true:
		print("Chips 1",location)
		get_node("Checkpoint_green1").visible = true
		get_node("Checkpoint_red1").visible = false
		get_node("Checkpoint_red1/CollisionShape2D").set_deferred("disabled", true)
	if location >= GameData.CP2_location and location <= GameData.CP3_location and GameData.isCheckpointPassed == true:
		print("Chippy location2: ", location)
		get_node("Checkpoint_green2").visible = true
		get_node("Checkpoint_red2").visible = false
		get_node("Checkpoint_red2/CollisionShape2D").set_deferred("disabled", true)
		
	if location >= GameData.CP3_location and location <= GameData.CP4_location and GameData.isCheckpointPassed == true:
		print("Chippy location3: ", location)
		get_node("Checkpoint_green3").visible = true
		get_node("Checkpoint_red3").visible = false
		get_node("Checkpoint_red3/CollisionShape2D").set_deferred("disabled", true)
	if location >= GameData.CP4_location and location <= get_node("Checkpoint_red5").teleport_location and GameData.isCheckpointPassed == true:
		print("Chippy location4: ", location)
		get_node("Checkpoint_green4").visible = true
		get_node("Checkpoint_red4").visible = false
		get_node("Checkpoint_red4/CollisionShape2D").set_deferred("disabled", true)
	
func update_interface() -> void:
	score.text = "Punktid: %s" % PlayerData.score

func _on_request_completed(result, response_code, headers, body):
	print("Processing the Response")
	var json = JSON.parse(body.get_string_from_utf8())
	var data = json.result
	print("GetData processed: ", data["username"])
	Savetofile.save_user(data["username"])
	GameData.playerCode = int(data["code"])
	usernameL.text = Savetofile.load_save_file()
