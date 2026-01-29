extends State

@export var idle_state : State
@export var move_speed : float = 300
@export var acceleration : float = 10

var input : Vector2

func enter() -> void:
	parent.velocity = Vector2(0,0)
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	var player_input = get_input()
	parent.velocity = lerp(parent.velocity, player_input * move_speed, delta * acceleration)
	
	if abs(parent.velocity.x) < 10 and abs(parent.velocity.y) < 10 and not player_input:
		return idle_state
	
	if abs(parent.velocity.x) > abs(parent.velocity.y):
		parent.animations.play("MoveRight")
		parent.animations.flip_h = parent.velocity.x < 0
	else:
		if parent.velocity.y > 0:
			parent.animations.play("MoveDown")
		else:
			parent.animations.play("MoveUp")
				
	parent.move_and_slide()
	
	return null

func get_input() -> Vector2:
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return input.normalized()

	
