extends State

func enter() -> void:
	parent.animations.play("Falling")
	get_parent().get_parent().player_shape.queue_free()
	get_parent().get_parent().z_index = -1
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
