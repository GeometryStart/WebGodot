extends Area2D
func _physics_process(_delta):
	var bodies= get_overlapping_bodies()
	for body in bodies:
		if body.name=="Player":			
			body.set_position(GameData.player_location1)
				
