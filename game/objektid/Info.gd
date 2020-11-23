extends Control
var my_data = {
		"username": GameData.userName,
		"score": GameData.playerScore, 
		"code": GameData.playerCode
}
onready var soundON = get_node("SoundON2")
onready var soundOFF = get_node("SoundOFF")
var my_url="https://digiseiklus.digikapp.ee/digiseiklus/create.php"
func _ready():
	
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 4
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AudioEffects.get_node("Level1_taust").stop()
	

func _on_Exit_pressed():
	_make_post_request(my_url, my_data, false)
	
	OS.shell_open("https://digiseiklus.digikapp.ee/digiseiklus/tulemused.php")

func _on_Sound_pressed():
	if soundON.visible == true:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true) 
		soundON.visible = false
		soundOFF.visible = true
		print("sound off")
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		soundON.visible = true
		soundON.texture_normal
		soundOFF.visible = false
		print("sound on")

func _on_Exit_toMain_pressed():
	get_tree().change_scene("res://src/UserInterface.tscn")


func _on_Tiim_pressed():
	get_tree().change_scene("res://src/Tiimist.tscn")
	


func _on_Juhend_pressed():
	get_tree().change_scene("res://src/Juhend.tscn")
	

func _on_Alusta_pressed():
	get_tree().change_scene("res://src/Vaheleht1.tscn")
func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	print("Sent to server: ", query)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPPOSTRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)	


func _on_HTTPPOSTRequest_request_completed(result, response_code, headers, body):
	print("Processing the Response")
	var json = JSON.parse(body.get_string_from_utf8())
	var data = json.result
	print("Response is : ", data)	
