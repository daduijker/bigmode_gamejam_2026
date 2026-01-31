extends Area2D

@export var player: Player

var registered_frets: Array[Node2D] = []
var selected_fret: Node2D

func register_fret(fret: Node2D):
	registered_frets.push_back(fret)

func unregister_fret(fret: Node2D):
	var index = registered_frets.find(fret)
	if index != -1:
		registered_frets.remove_at(index)

func _process(delta: float) -> void:
	#print_debug(selected_fret)
	if len(registered_frets) > 0:
		registered_frets.sort_custom(_sort_by_distance_to_player)
		selected_fret = registered_frets[0]
	else:
		selected_fret = null


func _sort_by_distance_to_player(area1: Node2D, area2: Node2D):
	var d_area1_to_player = player.global_position.distance_to(area1.global_position)
	var d_area2_to_player = player.global_position.distance_to(area2.global_position)
	return d_area1_to_player < d_area2_to_player


func _on_area_entered(area: Area2D) -> void:
		if area.get_parent().is_in_group("fret"):
			register_fret(area.get_parent())


func _on_area_exited(area: Area2D) -> void:
		if area.get_parent().is_in_group("fret"):
			unregister_fret(area.get_parent())
