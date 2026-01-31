extends Button
class_name Menu

const GAME = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _pressed():
	get_tree().change_scene_to_packed(GAME)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
