extends Area2D
@onready var player: CharacterBody2D = $"../Player"
@onready var houseHolder: InstancePlaceholder = $"../House_1"
@onready var houseNode: StaticBody2D

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	position = player.global_position

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.is_in_group("trigger_house"):
		print("create_instance")
		houseNode = houseHolder.create_instance()

func _on_area_exited(area: Area2D) -> void:
	print(area.name)
	if area.is_in_group("trigger_house"):
		print("FREE")
		houseNode.queue_free()
