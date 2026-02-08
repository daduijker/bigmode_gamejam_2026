extends CharacterBody2D
@onready var fireball_animations: AnimatedSprite2D = $FireballAnimations
var attack_dir : float
var attack_vel : float
var attack_knockback_mod : float
var hit : bool = false

func _ready() -> void:
	fireball_animations.play("default")


func _physics_process(delta: float) -> void:
	if not hit:
		velocity = Vector2(attack_vel, 0).rotated(attack_dir)
		fireball_animations.flip_h = velocity.x < 0
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_fireball_collision_body_entered(body: Node2D) -> void:
	hit = true
	fireball_animations.flip_h = velocity.x < 0
	velocity = Vector2.ZERO
	#rotation += 135
	fireball_animations.play("hit")
	if body.is_in_group("player"):
		body.state_machine.change_state(body.state_machine.get_node("Hurt"))
		body.velocity = Vector2(attack_vel * attack_knockback_mod, 0).rotated(attack_dir)
  
