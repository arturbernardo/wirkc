extends CharacterBody2D
var current_direction = Vector2()
var change_direction
@export var speed = 20

func _ready():
	change_direction = 3

func _process(delta: float) -> void:
	petrolling(delta)

func petrolling(delta):
	if (change_direction == 0):
		move_up(delta)
	if (change_direction == 1):
		move_down(delta)
	if (change_direction == 2):
		move_left(delta)
	if (change_direction == 3):
		move_right(delta)
		
func diagonal_movement(diagonal):
	var screen_pos = Vector2()
	screen_pos.x = diagonal.x - diagonal.y
	screen_pos.y = (diagonal.x + diagonal.y)
	return screen_pos

func move_up(delta):
	velocity += diagonal_movement(Vector2.UP * speed * delta)
	$anim.play("move_up_right")
	move_and_slide()
	
func move_down(delta):
	velocity += diagonal_movement(Vector2.DOWN * speed * delta)
	$anim.play("move_down_left")
	move_and_slide()

func move_left(delta):
	$anim.play("move_down_left")
	velocity += diagonal_movement(Vector2.LEFT * speed * delta)
	move_and_slide()
	
func move_right(delta):
	$anim.play("move_down_right")
	velocity += diagonal_movement(Vector2.RIGHT * speed * delta)
	move_and_slide()

func _on_timer_timeout() -> void:
	velocity = lerp(velocity, Vector2.ZERO, 1)
	change_path()
	$Timer.start()

func change_path():
	change_direction = randi() % 4


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			player_data.health -= 1
