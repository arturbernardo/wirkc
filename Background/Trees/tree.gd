extends StaticBody2D

@export var transparency = 0.3
@export var opaque = 1.0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = transparency


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = opaque
