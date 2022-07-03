# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# node
onready var ScoreMarker: Node2D = $Game/ScoreMarker

# const
const SPEED_X = K.SPEED_X
const SCORE_FACTOR: float = 1.0 / 20


func _ready():
	MgrNft.reload_nft()
	__reset()
	print("Game Start")


func __reset():
	ScoreMarker.position = Vector2.ZERO


func _physics_process(dt):
	__update_marker(dt)


func __update_marker(dt):
	ScoreMarker.position.x -= SPEED_X * dt
	G.score = abs(floor(ScoreMarker.position.x * SCORE_FACTOR))
