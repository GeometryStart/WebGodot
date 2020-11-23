extends Area2D
export(String, FILE, "*.tscn") var level_scene
export (Vector2) var teleport_location = Vector2(11272.292, 784.144)
var isCheckpoint3 = true

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(level_scene)
			CheckpointRed2.isCheckpoint2 = false
