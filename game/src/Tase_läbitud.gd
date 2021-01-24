extends Control
onready var score: Label = get_node("Label")
onready var username: Label = get_node("Label2")
var my_data = {
		"username": GameData.userName,
		"score": GameData.playerScore, 
		"code": GameData.playerCode
	}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	PlayerData.connect("score_updated", self, "update_interface")
	username.text = GameData.userName
	score.text = str(GameData.playerScore)
	_make_post_request(GameData.update_score_url, my_data, false)

	
func _on_Edasi_pressed():
	OS.shell_open(GameData.gameResults_url)
	get_tree().change_scene("res://src/Vaheleht2.tscn")
	
	
func _on_Katkesta_pressed():
	get_tree().change_scene("res://src/UserInterface.tscn")

#func update_interface() -> void:
#	var data = Savetofile.load_data("save_file", null, "user")
#	print("Failist data on see: ", data)
	
	
func update_score(new_score):
	if new_score%10 == 0:
		Savetofile.save_data(new_score, "save_file", "user")
	
	
func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	print("Sent to server: ", query)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPPOSTRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("Processing the Response")
	var json = JSON.parse(body.get_string_from_utf8())
	var data = json.result
	print("Response is : ", data)	


func _on_TextureButton_pressed():
	JavaScript.eval('window.location.replace("https://digiseiklus.ee/tulemused.php")')
