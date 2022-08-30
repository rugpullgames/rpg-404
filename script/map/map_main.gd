# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# node
onready var ScoreMarker: Node2D = $Game/ScoreMarker
onready var BGM: AudioStreamPlayer2D = $BGM
onready var Floors: Node2D = $Game/Floors
onready var player: KinematicBody2D = $Game/Player

# const
const SPEED_X = K.SPEED_X
const SCORE_FACTOR: float = 1.0 / 20
const PLAYER_DEFAULT_POS_X = 180


func _ready():
	print("Game Init")
	__bind_events()
	MgrNft.reload_nft()
	__reset()


func __bind_events():
	var error_code = Events.connect("game_ready", self, "__ready_game")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_run", self, "__run_game")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_end", self, "__end_game")
	assert(error_code == OK, error_code)


func __reset():
	ScoreMarker.position = Vector2.ZERO


func _process(dt):
	if G.game_state == K.GameState.READY:
		__update_player(dt)
	elif G.game_state == K.GameState.RUNNING:
		__update_marker(dt)
		__update_bgm()


func __update_player(dt):
	player.position.x += SPEED_X * dt
	if player.position.x >= PLAYER_DEFAULT_POS_X:
		player.position.x = PLAYER_DEFAULT_POS_X
		Events.emit_signal("game_run")


func __update_marker(dt):
	ScoreMarker.position.x -= SPEED_X * dt
	G.score = abs(floor(ScoreMarker.position.x * SCORE_FACTOR))
	G.factor += K.FACTOR_DELTA * dt


func __update_bgm():
	BGM.pitch_scale = (
		(G.factor - K.BGM_DEFAULT_PITCH_SCALE) * K.BGM_FACTOR
		+ K.BGM_DEFAULT_PITCH_SCALE
	)


func __ready_game():
	Floors.visible = true
	player.position.x = -20
	player.position.y = 150
	ScoreMarker.position.x = 0
	G.factor = 1
	G.score = 0
	BGM.pitch_scale = K.BGM_DEFAULT_PITCH_SCALE
	G.game_state = K.GameState.READY
	print("Game Ready")


func __run_game():
	BGM.seek(0)
	if G.bgm_audio:
		BGM.play()
	G.game_state = K.GameState.RUNNING
	print("Game Start")


func __end_game():
	G.game_state = K.GameState.END
	BGM.stop()
	Floors.visible = false
	print("Game Over")
