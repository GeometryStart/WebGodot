extends Control


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$ColorRect/ExitToMain.grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		print(TeleporterData.soundIsON)
#		if TeleporterData.soundIsON:
#			get_node("ColorRect/SoundON").visible = true
#		else:
#			get_node("ColorRect/SoundOFF").visible = true
#
func _on_Continue_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	if TeleporterData.isQuestionBox:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	else:
#		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_ExitToMain_pressed():
	var my_data = {
		"username": GameData.userName, 
		"code": GameData.playerCode,
		"score": GameData.playerScore
	}
	_make_update_request(GameData.update_score_url, my_data, false)
	
	get_tree().paused = not get_tree().paused
	visible = not visible
	
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
