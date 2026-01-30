extends CharacterBody2D
class_name Player

@onready var animations : AnimatedSprite2D = $Animations
@onready var state_machine : StateMachine = $StateMachine

func _ready() -> void:
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
		

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
