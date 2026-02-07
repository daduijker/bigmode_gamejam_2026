extends Node
@onready var next_lick_timer: Timer = $NextLickTimer
@onready var dmg_cooldown_timer: Timer = $DmgCooldownTimer
@onready var LickManager : Node = get_tree().get_first_node_in_group("LickManager")


@onready var difficulty : int = 0
@export var difficulty_threshold : int
@export var note_timing_threshold : int

var player_life = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

signal lose_health(dmg_amount, current_health)

func lick_successful() -> void:
	print_debug("Lick successful")
	LickManager.stop_lick()
	difficulty += 1
	next_lick_timer.start()


func lick_unsuccessful() -> void:
	print_debug("Lick unsuccessful")
	LickManager.stop_lick()
	if dmg_cooldown_timer.time_left == 0:
		take_damage(1)
		
	dmg_cooldown_timer.start()
	next_lick_timer.start()


func take_damage(amount):
	player_life -= amount
	lose_health.emit(amount, player_life)
	if player_life <= 0:
		player_death()

func player_death():
	print("lol, you died!")
	await get_tree().create_timer(3, false).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Take damage button for debugging purposes
func _on_button_pressed() -> void:
	take_damage(1) # Replace with function body.

func _on_button_2_pressed() -> void:
	take_damage(2) # Replace with function body.


func _on_next_lick_timer_timeout() -> void:
	#print_debug("Starting a new lick")
	LickManager.start_new_lick()
