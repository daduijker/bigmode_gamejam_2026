extends Node

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")

var active_frets : Array[Node2D] = []
var selected_fret : Node2D

func register_fret(fret: Node2D):
	active_frets.push_back(fret)

func unregister_fret(fret: Node2D):
	var index = active_frets.find(fret)
	if index != -1:
		active_frets.remove_at(index)
		
func _process(delta: float) -> void:
	if len(active_frets) > 0:
		active_frets.sort_custom(_sort_by_distance_to_player)
		selected_fret = active_frets[0]
	else:
		selected_fret = null


func _sort_by_distance_to_player(area1: Node2D, area2: Node2D):
	var player : CharacterBody2D = get_tree().get_first_node_in_group("player") # Temporary fix
	var d_area1_to_player = player.global_position.distance_to(area1.global_position)
	var d_area2_to_player = player.global_position.distance_to(area2.global_position)
	return d_area1_to_player < d_area2_to_player
