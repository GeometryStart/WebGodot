extends Area2D
export(String, FILE, "*.tscn") var level_scene
export (Vector2) var teleport_location = Vector2(14425, 591)
var isCheckpoint4 = true

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(level_scene)
			CheckpointRed3.isCheckpoint3 = false
