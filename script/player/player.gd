extends KinematicBody2D

const GRAVITY = 1500
const JUMP_FORCE = 400
const LONG_JUMP_TIME = 0.1

var velocity = Vector2()
var screen_size
var longJump = false
var tt = 0


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(dt):
	velocity.y += dt * GRAVITY

	if is_on_floor():
		longJump = false
		tt = 0

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_FORCE

	if Input.is_action_pressed("ui_accept") and not longJump and tt >= LONG_JUMP_TIME:
		velocity.y = -JUMP_FORCE * 1.3
		longJump = true

	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_pressed("ui_accept"):
		tt += dt

	# prevent player going out of screen
	position.y = clamp(position.y, 0, screen_size.y)
