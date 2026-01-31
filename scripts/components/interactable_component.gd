extends Area2D
class_name InteractableComponent

@export var use_name: String = "use"
@export var can_use: bool

@export var grab_name : String = "pick up"
@export var can_grab: bool

@export var animations : AnimatedSprite2D

var use: Callable = func():
	pass
	
var grab: Callable = func():
	pass
	
var drop: Callable = func():
	pass

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)
	print_debug(body)

func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
