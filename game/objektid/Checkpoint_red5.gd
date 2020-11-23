extends Area2D
export(String, FILE, "*.tscn") var level_scene
export (Vector2) var teleport_location = Vector2(19104, 591)
var isCheckpoint5 = true

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(level_scene)
			CheckpointRed4.isCheckpoint4 = false
