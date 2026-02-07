extends CharacterBody2D
class_name Player

@onready var animations : AnimatedSprite2D = $Animations
@onready var state_machine : StateMachine = $StateMachine
@onready var GameManager : Node = get_tree().get_first_node_in_group("GameManager")
@onready var player_shape: CollisionShape2D = $PlayerShape

#@export_file var inv_shader
@export var am_i_the_main_player = true

func _ready() -> void:
	if am_i_the_main_player:
		animations.material = null
	else:
		self.add_to_group("Modifiers")
		
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
		

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func player_falls() -> void:
	pass
	
func _on_animations_animation_finished() -> void:
	if am_i_the_main_player:
		GameManager.respawn_player()
	queue_free()
	
