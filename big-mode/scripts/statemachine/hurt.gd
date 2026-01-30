extends State

@export var idle_state : State
@export var max_hurt_time : float = 0.3

var hurt_time : float

func enter() -> void:
	hurt_time = max_hurt_time
	parent.velocity = Vector2(0,0)
	print_debug('hurt')
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	
	hurt_time -= delta
	if hurt_time <= 0:
		return idle_state
		
	return null
