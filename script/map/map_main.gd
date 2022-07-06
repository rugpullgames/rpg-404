# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# node
onready var ScoreMarker: Node2D = $Game/ScoreMarker
onready var BGM: AudioStreamPlayer2D = $BGM

# const
const SPEED_X = K.SPEED_X
const SCORE_FACTOR: float = 1.0 / 20


func _ready():
	print("Game Init")
	__bind_events()
	MgrNft.reload_nft()
	__reset()


func __bind_events():
	var error_code = Events.connect("game_run", self, "__run_game")
	assert(error_code == OK, error_code)
	error_code = Events.connect("player_die", self, "__end_game")
	assert(error_code == OK, error_code)


func __reset():
	ScoreMarker.position = Vector2.ZERO


func _physics_process(dt):
	__update_marker(dt)


func __update_marker(dt):
	ScoreMarker.position.x -= SPEED_X * dt
	G.score = abs(floor(ScoreMarker.position.x * SCORE_FACTOR))


func __run_game():
	G.gameState = K.GameState.RUNNING
	G.score = 0
	BGM.seek(0)
	BGM.play()
	print("Game Start")


func __end_game():
	G.gameState = K.GameState.END
	BGM.stop()
	print("Game Over")
