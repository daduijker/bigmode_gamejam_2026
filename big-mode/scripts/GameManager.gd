extends Node

var player_life = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

signal lose_health(dmg_amount, current_health)

func take_damage(amount):
	player_life -= amount
	lose_health.emit(amount, player_life)
	if player_life <= 0:
		player_death()

func player_death():
	print("lol, you died!")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Take damage button for debugging purposes
func _on_button_pressed() -> void:
	take_damage(1) # Replace with function body.

func _on_button_2_pressed() -> void:
	take_damage(2) # Replace with function body.
