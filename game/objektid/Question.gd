extends Node2D
export (String, FILE, "*.tscn") var level_scene
export (String) var question
export (String) var randAnswer
export (String) var answer1
export (String) var answer2
export (String) var answer3
export (Array)  var answers


var questionList = GameData.questionList1
var randomList


onready var button_right = get_node("VASTA")

var rightAnswer 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	randomize()
	if CheckpointRed1.isCheckpoint1:
		randomList = questionList[randi() % questionList.size()+1]	
	elif GameData.isCheckpointPassed and CheckpointRed2.isCheckpoint2:
		questionList = GameData.questionList2
		randomList = questionList[randi() % questionList.size()+1]
	elif GameData.isCheckpointPassed and CheckpointRed3.isCheckpoint3:
		questionList = GameData.questionList3
		randomList = questionList[randi() % questionList.size()+1]
	elif GameData.isCheckpointPassed and GameData.checkpoint == CheckpointRed3:
		questionList = GameData.questionList4
		randomList = questionList[randi() % questionList.size()+1]
	elif GameData.isCheckpointPassed and CheckpointRed4.isCheckpoint4:
		questionList = GameData.questionList4
		randomList = questionList[randi() % questionList.size()+1]
	elif GameData.isCheckpointPassed and CheckpointRed5.isCheckpoint5:
		questionList = GameData.questionList5
		randomList = questionList[randi() % questionList.size()+1]
		GameData.isCheckpoint5 = true
	else:
		print("Rohkem pole Checkpointi")
		
		
	question = randomList.get("label")
	get_node("Question").set_text(question)
	
	var answersL = []
	for ans in randomList.values():
		if ans == randomList.get("answer1") or ans == randomList.get("answer2"): 
			answersL.insert(0, ans)
		else: 
			if ans == randomList.get("answer_right"):
				rightAnswer = ans
				answersL.insert(0, ans)
					

	get_node("Vastuste_container/RadioBtn_conteiner/Vastus1").set_text(answersL[0]) 
	get_node("Vastuste_container/RadioBtn_conteiner/Vastus2").set_text(answersL[1])    
	get_node("Vastuste_container/RadioBtn_conteiner/Vastus3").set_text(answersL[2])
	
	button_right.connect("pressed", self, "_on_VASTA_pressed", [get_name()])
var counter = 0	

func _on_Vastus1_pressed():
	if rightAnswer == get_node("Vastuste_container/RadioBtn_conteiner/Vastus1").text:
		counter += 1
		print(counter, rightAnswer)
		GameData.isCheckpointPassed = true
	else:
		if counter >= 1:
			counter = 0
		print(counter, "vale vastus")

func _on_Vastus2_pressed():
	if  rightAnswer == get_node("Vastuste_container/RadioBtn_conteiner/Vastus2").text:
		counter += 1
		print(counter, rightAnswer)
		GameData.isCheckpointPassed = true
	else:
		if counter >= 1:
			counter = 0
		print(counter, "vale vastus")
	

func _on_Vastus3_pressed():
	if rightAnswer == get_node("Vastuste_container/RadioBtn_conteiner/Vastus3").text:
		counter += 1
		print(counter," ", rightAnswer)
		GameData.isCheckpointPassed = true
	else:
		if counter >= 1:
			counter = 0
		print(counter, "vale vastus")
	

func _on_VASTA_pressed():
	if counter >= 1 and !GameData.isCheckpoint5:
		get_tree().change_scene("res://objektid/Question_AnswerRight.tscn")
	elif counter >=1 and GameData.isCheckpoint5:
		get_tree().change_scene("res://src/Tase_läbitud.tscn")
		print("Chekpoint5 läbitud ja punktid on: ", PlayerData.score)
	else:
		get_tree().change_scene("res://objektid/Question_AnswerWrong.tscn")	
		

