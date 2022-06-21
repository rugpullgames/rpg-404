extends KinematicBody2D

const GRAVITY = 1500
const JUMP_FORCE = 450

var velocity = Vector2()
var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_FORCE

	velocity = move_and_slide(velocity, Vector2.UP)

	# prevent player going out of screen
	position.y = clamp(position.y, 0, screen_size.y)
