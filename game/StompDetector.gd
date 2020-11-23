extends Area2D

var enemyDead = false
var color=.7

func _physics_process(_delta):
	var bodies= get_overlapping_bodies()
	for body in bodies:
		if body.name=="Player":
			score()
			AudioEffects.get_node("surm").play()
	
func score() -> void:
	PlayerData.score += 10
	GameData.playerScore = PlayerData.score
	
	get_parent().queue_free()
