extends Node

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var fret_list : Array[Node] = get_tree().get_nodes_in_group("fret")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('E_string'):
		print_debug("E")
	if Input.is_action_just_pressed('A_string'):
		print_debug("A")
	if Input.is_action_just_pressed('D_string'):
		print_debug("D")
	if Input.is_action_just_pressed('G_string'):
		print_debug("G")
	return

func _process(delta: float) -> void:
	#for fret in fret_list:
		#if fret.is_active:
			#print_debug(fret)
	pass
