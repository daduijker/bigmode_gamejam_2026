extends Node
@onready var next_lick_timer: Timer = $NextLickTimer
@onready var dmg_cooldown_timer: Timer = $DmgCooldownTimer
@onready var text_timer: Timer = $TextTimer
@export var my_font: Font

@onready var LickManager : Node = get_tree().get_first_node_in_group("LickManager")
@onready var fall_areas : Array[Node] = get_tree().get_nodes_in_group("FallZone")
@onready var player_spawns: Array[Node] = get_tree().get_nodes_in_group("PlayerSpawn")
@onready var sick_lick_label : RichTextLabel = get_tree().get_first_node_in_group("SickLickLabel")
@onready var difficulty : int = 0

@export var difficulty_threshold : int
@export var note_timing_threshold : int

var player_instance = preload("res://scenes/player.tscn")

var player_life = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for fall_area in fall_areas:
		fall_area.body_entered.connect(_on_body_entered)

# fall zones
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.state_machine.change_state(body.state_machine.falling_state)
		
# player respawn after falling
func respawn_player() -> void:
	LickManager.stop_lick() 
	take_damage(1)
	var instance = player_instance.instantiate()
	instance.global_position = player_spawns[0].global_position
	get_tree().current_scene.add_child(instance)
	next_lick_timer.start()

signal lose_health(dmg_amount, current_health)

func lick_successful() -> void:
	print_debug("Lick successful")
	LickManager.stop_lick()
	delete_modifiers()
	difficulty += 1
	next_lick_timer.start()
	


func lick_unsuccessful() -> void:
	print_debug("Lick unsuccessful")
	LickManager.stop_lick()
	delete_modifiers()
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

func display_sick_lick() -> void: 
	var word_list = ["SWEET", "SICK", "STELLAR", "SPLENDID", "SUPREME", "SLICK", \
	"SAVAGE", "SMASHING", "SPICY", "SMOOTH", "SUBLIME", "SPECTACULAR", "SENSATIONAL",\
	 "SOLID", "STUNNING", "SAUCY", "STEEZY"] 
	var text_addon = "[center][br][font_size=40]"
	var text_colors = ["[color=dark_cyan]","[color=spring_green]","[color=gold]",\
	"[color=dark_red]", "[color=midnight_blue]"," [color=hot_pink]"]
	var text_mod = ["[shake]", "[tornado freq=2.0]"]
	
	sick_lick_label.text = text_colors.pick_random() + text_mod.pick_random() + text_addon \
	+ word_list.pick_random() + " LICK"
	sick_lick_label.visible = true
	
	text_timer.start()

func _on_text_timer_timeout() -> void:
	sick_lick_label.visible = false
	

	
	
func spawn_clones() -> void:
	get_tree().get_first_node_in_group("player").queue_free()
	
	var instance = player_instance.instantiate()
	instance.global_position = player_spawns[1].global_position
	get_tree().current_scene.add_child(instance)
	
	var instance_clone = player_instance.instantiate()
	instance_clone.global_position = player_spawns[2].global_position
	instance_clone.am_i_the_main_player = false
	get_tree().current_scene.add_child(instance_clone)

	
func delete_modifiers() -> void:
	var modifiers = get_tree().get_nodes_in_group("Modifiers")
	if modifiers:
		for item in modifiers:
			item.queue_free()
