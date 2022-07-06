# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

var cloudUsed = {}
var score = 0

var gameState = K.GameState.INIT


func _ready():
	reset()


func reset():
	cloudUsed.clear()
	score = 0
