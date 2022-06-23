# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Area2D

# node
onready var SprBarrier: Sprite = $SprBarrier

# const
const SCREEN_WIDTH = 900
const DEFAULT_POS_X = SCREEN_WIDTH + 100
const SPEED_X = 300

# local var
var moving = false


func reset(texture):
	if not texture:
		push_warning("Barrier texture is null.")
		return

	SprBarrier.texture = texture
	moving = true
	self.visible = true
	self.position.x = DEFAULT_POS_X


func _physics_process(dt):
	if moving:
		__move(dt)


func __move(dt):
	self.position.x -= SPEED_X * dt
	if self.position.x < -SCREEN_WIDTH - 100:
		moving = false
		self.visible = false
