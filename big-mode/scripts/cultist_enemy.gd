extends Node2D


@onready var attack_timer: Timer = $AttackTimer
@onready var fireball_spawnpoint: Node2D = $FireballSpawnpoint
@onready var cultist_animations: AnimatedSprite2D = $CultistAnimations

@export var min_attack_cd : float
@export var max_attack_cd : float
@export var attack_vel : int
@export var attack_knockback_mod : float

var fireball_instance = preload("res://scenes/fireball.tscn")

func _ready() -> void:
	cultist_animations.play("default")
	attack_timer.wait_time = randf_range(min_attack_cd, max_attack_cd)
	attack_timer.start()
	cultist_animations.flip_h = position.x < (Global.GameSize.x / 2)
	self.add_to_group("Modifiers")

func _on_attack_timer_timeout() -> void:
	attack_timer.wait_time = randf_range(min_attack_cd, max_attack_cd)
	#print("attack!")
	var fireball = fireball_instance.instantiate()
	fireball.attack_dir = find_vector_to_player().angle()
	fireball.attack_vel = attack_vel
	fireball.attack_knockback_mod = attack_knockback_mod
	fireball.global_position = fireball_spawnpoint.global_position
	get_tree().current_scene.add_child(fireball)
	
	
func find_vector_to_player() -> Vector2:
	var vector_to_player : Vector2 = \
	get_tree().get_first_node_in_group("mainplayer").global_position \
	- self.global_position
	return vector_to_player.normalized()
	
