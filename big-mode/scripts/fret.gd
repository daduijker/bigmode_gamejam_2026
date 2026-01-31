extends Node2D
class_name Fret

@export var string : String
@export var fret_number : int


@onready var is_active : bool = false

@onready var icon: Sprite2D = $Icon

func activate_fret() -> void:
	is_active = true
	icon.visible = true
	return
	
func deactivate_fret() -> void:
	is_active = false
	icon.visible = false
	return
