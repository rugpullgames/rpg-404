# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends AnimatedSprite


const SCREEN_WIDTH = K.SCREEN_WIDTH
const SCREEN_WIDTH_EXT = SCREEN_WIDTH + 300
const SPEED_X = K.SPEED_X

func _ready():
	self.position = Vector2(-100, -100)


func play_effect():
	self.frame = 0
	self.playing = true


func _process(dt):
	if G.gameState != K.GameState.RUNNING:
		return
	__move(dt)


func __move(dt):
	if G.gameState != K.GameState.RUNNING:
		return

	self.position.x -= SPEED_X * G.factor * dt
	self.position.x = fmod(self.position.x + SCREEN_WIDTH_EXT, SCREEN_WIDTH_EXT)
