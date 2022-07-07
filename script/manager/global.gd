# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

var cloudUsed = {}
var score = 0.0
var factor = 1.0

var gameState = K.GameState.INIT

var bgmAudio = true
var sfxAudio = true

func _ready():
	reset()


func reset():
	cloudUsed.clear()
	score = 0
