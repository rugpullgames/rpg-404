# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# node
onready var ScoreMarker: Node2D = $Game/ScoreMarker
onready var BGM: AudioStreamPlayer2D = $BGM
onready var UIEnd: Control = $UI/UIEnd
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


func _physics_process(dt):
	if G.gameState == K.GameState.READY:
		__update_player(dt)
	elif G.gameState == K.GameState.RUNNING:
		__update_marker(dt)
	elif G.gameState == K.GameState.END:
		__check_input()


func __update_player(dt):
	player.position.x += SPEED_X * dt
	if player.position.x >= PLAYER_DEFAULT_POS_X:
		player.position.x = PLAYER_DEFAULT_POS_X
		Events.emit_signal("game_run")


func __update_marker(dt):
	ScoreMarker.position.x -= SPEED_X * dt
	G.score = abs(floor(ScoreMarker.position.x * SCORE_FACTOR))


func __check_input():
	if Input.is_action_pressed("ui_accept"):
		__restart_game()


func __restart_game():
	Events.emit_signal("game_ready")


func __ready_game():
	G.gameState = K.GameState.READY
	UIEnd.visible = false
	Floors.visible = true
	player.position.x = -20
	player.position.y = 150


func __run_game():
	G.gameState = K.GameState.RUNNING
	G.score = 0
	BGM.seek(0)
	if G.bgmAudio:
		BGM.play()
	print("Game Start")


func __end_game():
	G.gameState = K.GameState.END
	BGM.stop()
	UIEnd.visible = true
	Floors.visible = false
	print("Game Over")


func _on_BtnRestart_pressed():
	__restart_game()
