extends Control

var life_indicators : Array[TextureRect]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var life_bar = $Life/HBoxContainer
	for life in life_bar.get_children():
		life_indicators.append(life)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_life_indicator(damage, current_health):
	for i in range(len(life_indicators)):
		life_indicators[i].get_child(0).set_frame(i < current_health)

func _on_game_manager_lose_health(dmg_amount: Variant, current_health: Variant) -> void:
	update_life_indicator(dmg_amount, current_health)
