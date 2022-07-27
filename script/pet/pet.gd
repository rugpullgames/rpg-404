# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Area2D

# node
onready var SprPet: Sprite = $SprPet

# const
const SCREEN_WIDTH = K.SCREEN_WIDTH
const DEFAULT_POS_X = SCREEN_WIDTH + 100
const MIN_DEFAULT_POS_Y = 100
const MAX_DEFAULT_POS_Y = 200
const MIN_SPEED_X = K.SPEED_X * 1.2
const MAX_SPEED_X = K.SPEED_X * 2
const MIN_SPEED_Y = K.SPEED_X * 0.1
const MAX_SPEED_Y = K.SPEED_X * 0.4
const MIN_OFFSET_Y = 10
const MAX_OFFSET_Y = 50

# local var
var defaultPosY
var speedX
var speedY
var offsetLimit
var direction


func _ready():
	self.position.x = DEFAULT_POS_X
	defaultPosY = rand_range(MIN_DEFAULT_POS_Y, MAX_DEFAULT_POS_Y)
	self.position.y = defaultPosY
	speedX = rand_range(MIN_SPEED_X, MAX_SPEED_X)
	speedY = rand_range(MIN_SPEED_Y, MAX_SPEED_Y)
	offsetLimit = rand_range(MIN_OFFSET_Y, MAX_OFFSET_Y)
	direction = pow(-1, randi() % 2)
	__bind_events()
	__reset()


func _exit_tree():
	__unbind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __unbind_events():
	Events.disconnect("update_traits", self, "__reset")


func __reset():
	__reset_pet_type()


func __reset_pet_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.pet:
		push_warning("Wrong NFT pet traits.")
		return
	var res = "res://texture/pet/%s.png" % [MgrNft.NFT_TRAITS.pet]
	SprPet.texture = load(res)


func _physics_process(dt):
	if G.gameState == K.GameState.READY:
		self.queue_free()
	elif G.gameState == K.GameState.RUNNING:
		__move(dt)


func __move(dt):
	self.position.x -= speedX * dt * G.factor
	if direction == 1:
		self.position.y += speedY * dt * G.factor
	else:
		self.position.y -= speedY * dt * G.factor
	if self.position.y >= defaultPosY + offsetLimit:
		direction = -1
	elif self.position.y <= defaultPosY - offsetLimit:
		direction = 1

	if self.position.x < -SCREEN_WIDTH - 100:
		self.queue_free()


func _on_Area2D_body_entered(body: KinematicBody2D):
	if not body:
		return

	if G.gameState == K.GameState.RUNNING:
		G.factor -= K.FACTOR_PET_DECR
		G.score += K.SCORE_PET_INCR
		body.play_audio_power_up()
		self.get_parent().play_boom_effect(self.position)
		self.queue_free()
