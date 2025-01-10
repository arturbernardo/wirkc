extends Area2D

@export var damage = 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_data.health -= damage
