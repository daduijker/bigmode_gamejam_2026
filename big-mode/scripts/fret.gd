extends Node2D
class_name Fret


func _on_fret_area_body_entered(body: Node2D) -> void:
	FretManager.register_fret(self)


func _on_fret_area_body_exited(body: Node2D) -> void:
	FretManager.unregister_fret(self)
