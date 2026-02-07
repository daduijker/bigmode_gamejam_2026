extends Node2D
class_name Fret

@export var string : String
@export var am_i_an_open_string : bool = false
@export var midi_code : int
@export var collision_shape_2d: CollisionShape2D

@onready var note_example_particles: GPUParticles2D = $NoteExampleParticles
@onready var note_play_particles: GPUParticles2D = $NotePlayParticles

@onready var is_active : bool = false

@onready var icon: Sprite2D = $Icon

func _enter_tree() -> void:
	if am_i_an_open_string:
		collision_shape_2d.disabled = true

func activate_fret() -> void:
	is_active = true
	#icon.visible = true
	return
	
func deactivate_fret() -> void:
	is_active = false
	#icon.visible = false
	return

func play_example() -> void:
	note_example_particles.emitting = true
	
func play_note() -> void:
	note_play_particles.emitting = true
