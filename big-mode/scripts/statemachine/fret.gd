extends State

@export var idle_state: State
@export var move_state: State

func enter() -> void:
	parent.velocity = Vector2(0,0)
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_released('press_fret'):
		return idle_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right') \
	or Input.is_action_pressed('move_up') or Input.is_action_pressed('move_down'):
		return move_state
	return null
