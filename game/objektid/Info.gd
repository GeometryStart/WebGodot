extends Control
var my_data = {
		"username": GameData.userName, 
		"code": GameData.playerCode,
		"score": GameData.playerScore
}

onready var soundON = get_node("SoundON2")
onready var soundOFF = get_node("SoundOFF")
onready var vastus = get_node("Vastus")


func _ready():
	get_node("Kasutajanimi").modulate = Color(30,171,171)
	get_node("Kood").modulate = Color(30,171,171)
	get_node("Kasutajanimi").add_color_override("font_color", Color.black)
	get_node("Kood").add_color_override("font_color", Color.black)
	$HTTPGetRequest2.connect("request_completed", self, "_on_HTTPGetRequest2_request_completed")
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 4
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AudioEffects.get_node("Level1_taust").stop()
	print(vastus.text)

func _on_Exit_pressed():
	_make_update_request(GameData.update_score_url, my_data, false)
#	OS.shell_open("https://digiseiklus.digikapp.ee/digiseiklus/tulemused2.html")

	
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

func _on_Juhend_pressed():
	get_tree().change_scene("res://src/Juhend.tscn")
	
func _on_Alusta_pressed():
#	get_tree().change_scene("res://src/Vaheleht1.tscn")
	var username = get_node("Kasutajanimi").text
	var code = get_node("Kood").text
	
	if !username.empty() and !code.empty():
		GameData.userName = username
		GameData.playerCode = code
		$HTTPGetRequest2.request(GameData.getGameCode)
		
	else:
		vastus.text = "Kasutajanimi või kood on sisestamata"
	
	
func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	print("Sent to server: ", query)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("Processing the Response save user")
	var data = body.get_string_from_utf8()
#	var data = json.result
	if response_code == 200:
		vastus.text = data
		get_tree().change_scene("res://src/Vaheleht1.tscn")	
	else: 
		vastus.text = data
		print("Mängima ei saa!")
	
func _make_update_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	print("Update Sent to server: ", query)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPUpdateRequest2.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)	

func _on_HTTPUpdateRequest2_request_completed(result, response_code, headers, body):
	print("Processing the Response update")
	var data = body.get_string_from_utf8()
#	var data = json.result
	print("Uuendamine õnnestus")
	JavaScript.eval('window.location.replace("https://digiseiklus.digikapp.ee/ver1/tulemused.php")')

func _on_HTTPGetRequest2_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print("get things from website: ", json.result)
	if float(GameData.playerCode) != json.result:
		vastus.text = "Vale kood, proovi uuesti"
	else:
		var my_data = {
		"username": GameData.userName, 
		"code": GameData.playerCode
		}
		_make_post_request(GameData.save_user_url, my_data, false)

func _on_Tiim_pressed():
	get_tree().change_scene("res://src/Tiimist.tscn")

