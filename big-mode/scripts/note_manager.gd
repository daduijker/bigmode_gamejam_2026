extends Node

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var fret_list : Array[Node] = get_tree().get_nodes_in_group("fret")


func _unhandled_input(event: InputEvent) -> void:
	var played_string: String = ""
	if Input.is_action_just_pressed('E_string'):
		played_string = "E"
		print_played_note(played_string)
	if Input.is_action_just_pressed('A_string'):
		played_string = "A"
		print_played_note(played_string)
	if Input.is_action_just_pressed('D_string'):
		played_string = "D"
		print_played_note(played_string)
	if Input.is_action_just_pressed('G_string'):
		played_string = "G"
		print_played_note(played_string)
	return
	
func print_played_note(played_string: String) -> void:
	var played_note : String = played_string + "0"
	if find_fret(played_string, find_highest_fret(played_string)):
		played_note = find_fret(played_string, find_highest_fret(played_string)).string \
		 + str(find_fret(played_string, find_highest_fret(played_string)).fret_number)
	print_debug(played_note)
	return

func find_highest_fret(string: String) -> int:
	var highest_fret : int = 0
	for fret in fret_list:
		if fret.string == string and fret.fret_number > highest_fret and fret.is_active:
			highest_fret = fret.fret_number
	return highest_fret
	
func find_fret(string: String, fret_number: int) -> Fret:
	for fret in fret_list: 
		if fret.string == string and fret.fret_number == fret_number:
			return fret
	return null

func _process(delta: float) -> void:
	pass
