extends Node

var player_life = 3

func take_damage(amount):
	player_life -= amount
	if player_life == 0:
		player_death()

func player_death():
	print("lol, you died!")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Take damage button for debugging purposes
func _on_button_pressed() -> void:
	take_damage(1) # Replace with function body.
