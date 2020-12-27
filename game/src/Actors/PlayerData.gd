extends Node

signal score_updated
signal player_died


var score: = 0 setget set_score
var deaths: = 0 setget set_deaths 
var user = "user" setget set_user

func set_user(value: String)-> void:
	user = value
	emit_signal("user_added")
func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
func get_score():
	return score
	emit_signal("scores")
func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")

	
