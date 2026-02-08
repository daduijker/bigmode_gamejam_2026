extends Node
class_name Lick

@export_file var lick_music
@export_file var lick_midi
@export var bmp : int
@export var difficulty : int
@export var spawn_clone : bool
@export var spawn_cultists_list : Array[int]

@onready var player_spawns: Array[Node] = get_tree().get_nodes_in_group("PlayerSpawn")

var cultist_instance = preload("res://scenes/cultist_enemy.tscn")
var player_instance = preload("res://scenes/player.tscn")

func activate_lick_modifiers() -> void:
	if spawn_clone:
		spawn_clones()
	if spawn_cultists_list:
		spawn_cultists()
	

func spawn_clones() -> void:
	get_tree().get_first_node_in_group("player").queue_free()
	
	var instance = player_instance.instantiate()
	instance.global_position = player_spawns[1].global_position
	get_tree().current_scene.add_child(instance)
	
	var instance_clone = player_instance.instantiate()
	instance_clone.global_position = player_spawns[2].global_position
	instance_clone.am_i_the_main_player = false
	get_tree().current_scene.add_child(instance_clone)

	for i in [1,2]:
		var spawn_animation = Global.spawn_animation.instantiate()
		spawn_animation.global_position = player_spawns[i].global_position
		get_tree().current_scene.add_child(spawn_animation)

func spawn_cultists() -> void:
	for spawn in spawn_cultists_list:
		var instance_cultist = cultist_instance.instantiate()
		instance_cultist.global_position = player_spawns[spawn].global_position
		get_tree().current_scene.add_child(instance_cultist)
