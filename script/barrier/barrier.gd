# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Area2D

# node
onready var SprBarrier: Sprite = $SprBarrier
onready var CollsionShape: CollisionShape2D = $CollisionShape2D

# const
const SCREEN_WIDTH = 900
const DEFAULT_POS_X = SCREEN_WIDTH + 100
const SPEED_X = 300
const GRAVITY = 1500

# local var
var velocity = Vector2()
var moving = false
var shape2d: RectangleShape2D


func _ready():
	shape2d = CollsionShape.shape as RectangleShape2D


func reset(texture):
	if not texture:
		push_warning("Barrier texture is null.")
		return

	var textureSize = texture.get_size()
	SprBarrier.texture = texture
	SprBarrier.offset = -textureSize
	CollsionShape.position.x = -textureSize.x * 2.5
	CollsionShape.position.y = -textureSize.y * 2
	shape2d.extents = textureSize / 2

	moving = true
	self.visible = true
	self.position.x = DEFAULT_POS_X


func _physics_process(dt):
	if moving:
		__move(dt)


func __move(dt):
	velocity.y += dt * GRAVITY

	self.position.x -= SPEED_X * dt
	if self.position.x < -SCREEN_WIDTH - 100:
		moving = false
		self.visible = false
