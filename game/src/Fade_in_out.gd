extends CanvasLayer

signal scene_change()

onready var animation_player = get_node("Black/AnimationPlayer")
onready var black = get_node("Black")

func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fadeOut")
	yield(animation_player, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Levels/Level1.tscn")
	animation_player.play_backwards("fadeOut")
