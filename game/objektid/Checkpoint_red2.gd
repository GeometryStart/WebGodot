extends Area2D
export(String, FILE, "*.tscn") var level_scene

export (Vector2) var teleport_location = Vector2(7402.332, 700.833)
var isCheckpoint2 = true

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(level_scene)
			CheckpointRed1.isCheckpoint1 = false
