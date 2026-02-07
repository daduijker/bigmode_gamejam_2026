extends Node

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var fret_list : Array[Node] = get_tree().get_nodes_in_group("fret")
@onready var LickManager : Node = get_tree().get_first_node_in_group("LickManager")


func _unhandled_input(event: InputEvent) -> void:
	var played_string: String = ""
	if Input.is_action_just_pressed('E_string'):
		played_string = "E"
		player_played_note(played_string)
	if Input.is_action_just_pressed('A_string'):
		played_string = "A"
		player_played_note(played_string)
	if Input.is_action_just_pressed('D_string'):
		played_string = "D"
		player_played_note(played_string)
	if Input.is_action_just_pressed('G_string'):
		played_string = "G"
		player_played_note(played_string)
	return
	
func player_played_note(played_string: String) -> void:
	var played_note : int = 0
	played_note = find_highest_fret(played_string)
	LickManager.player_played_note(played_note)
	#print(played_note)
	print_debug(LickManager.time_passed)

func find_highest_fret(string: String) -> int:
	# Return the highest selected fret on a string in MIDI code
	var midi_code : int = 0
	for fret in fret_list:
		if fret.string == string and fret.midi_code > midi_code:
			if fret.is_active or fret.am_i_an_open_string:
				midi_code = fret.midi_code
	return midi_code
	
func find_fret(midi_code: int) -> Fret:
	# Return fret via MIDI code
	for fret in fret_list: 
		if fret.midi_code == midi_code:
			return fret
	return null

func _process(delta: float) -> void:
	pass
