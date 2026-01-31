extends State

@export var idle_state: State
@export var move_state: State
@export var fret_hitbox: Area2D

func enter() -> void:
	parent.velocity = Vector2(0,0)
	if fret_hitbox.selected_fret:
		fret_hitbox.selected_fret.activate_fret()
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_released('press_fret'):
		if fret_hitbox.selected_fret:
			fret_hitbox.selected_fret.deactivate_fret()
		return idle_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right') \
	or Input.is_action_pressed('move_up') or Input.is_action_pressed('move_down'):
		if fret_hitbox.selected_fret:
			fret_hitbox.selected_fret.deactivate_fret()
		return move_state
	return null
