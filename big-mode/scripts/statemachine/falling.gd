extends State

func enter() -> void:
	parent.animations.play("Falling")
	get_parent().get_parent().player_shape.queue_free()
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
