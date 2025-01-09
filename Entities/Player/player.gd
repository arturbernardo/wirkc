extends CharacterBody2D

const acceleration = 600
const friction = 400
var input = Vector2.ZERO

@export var speed = 80
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

var current_state = player_state.MOVE
enum player_state{MOVE, ATTACK, DEAD}

func _process(delta: float) -> void:
	match current_state:
		player_state.MOVE:
			player_movement(delta)
		player_state.ATTACK:
			sword_attack()


func diagonal_movement(diagonal):
	var screen_pos = Vector2()
	screen_pos.x = diagonal.x - diagonal.y
	screen_pos.y = (diagonal.x + diagonal.y)
	return screen_pos
	
func player_movement(delta): 
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input != Vector2.ZERO:
		animation_state()
		anim_state.travel("Move")
		velocity = velocity.limit_length(speed)
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			anim_state.travel("Idle")
			velocity = Vector2.ZERO
			
	if Input.is_action_just_pressed("ui_sword"):
		current_state = player_state.ATTACK
		
	velocity += diagonal_movement(input * acceleration * delta)
	move_and_slide()
	
func sword_attack():
	anim_state.travel("Attack")
	
func reset_state():
	current_state = player_state.MOVE
	
func animation_state():
	anim_tree.set("parameters/Idle/blend_position", input)
	anim_tree.set("parameters/Move/blend_position", input)
	anim_tree.set("parameters/Attack/blend_position", input)
