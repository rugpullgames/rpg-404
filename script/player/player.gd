extends KinematicBody2D

const GRAVITY = 1500
const JUMP_FORCE = 400
const LONG_JUMP_TIME = 0.1
const WEAPON_JUMP_UP_OFFSET = Vector2(-10, 10)
const WEAPON_JUMP_DOWN_OFFSET = Vector2(10, 15)
const WEAPON_MOVE_OFFSET = Vector2()

# nodes
onready var Emo: Sprite = $SprEmo
onready var Weapon: Sprite = $SprWeapon
onready var Pants: AnimatedSprite = $AsprPants
onready var AudioPlayer: AudioStreamPlayer2D = $AudioPlayer

# local variables
var velocity = Vector2()
var screenSize
var longJump = false
var tt = 0


func _ready():
	screenSize = get_viewport_rect().size


func _physics_process(dt):
	velocity.y += dt * GRAVITY

	if is_on_floor():
		longJump = false
		tt = 0

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_FORCE
		Emo.visible = true
		AudioPlayer.play()

	if Input.is_action_pressed("ui_accept") and not longJump and tt >= LONG_JUMP_TIME:
		velocity.y = -JUMP_FORCE * 1.3
		longJump = true
		if !AudioPlayer.is_playing():
			AudioPlayer.play()

	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_pressed("ui_accept"):
		tt += dt

	if is_on_floor():
		# move
		Pants.playing = true
		Weapon.moving = true
		Weapon.offset = WEAPON_MOVE_OFFSET
	else:
		# jump
		Pants.playing = false
		Pants.frame = 0 if velocity.y < 0 else 1
		Weapon.moving = false
		Weapon.offset = WEAPON_JUMP_UP_OFFSET if velocity.y < 0 else WEAPON_JUMP_DOWN_OFFSET

		# prevent player going out of screen
		# prevent player gDOWNng out of screen
	position.y = clamp(position.y, 0, screenSize.y)
