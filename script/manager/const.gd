# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

const SCREEN_WIDTH = 900
const SPEED_X = 300.0

const GameState = {INIT = 0, READY = 1, RUNNING = 2, END = 3}

# collision layers
enum CollsionLayer { BASEFLOOR = 0, PLAYER, BARRIER, PET }

const DATA_BACKGROUND = preload("res://script/data/data_background.gd").background

const CLOUDS = {
	"Day":
	[
		"res://texture/cloud/Cloud Day 01.png",
		"res://texture/cloud/Cloud Day 02.png",
		"res://texture/cloud/Cloud Day 03.png",
		"res://texture/cloud/Cloud Day 04.png",
		"res://texture/cloud/Cloud Day 05.png",
		"res://texture/cloud/Cloud Day 06.png",
		"res://texture/cloud/Cloud Day 07.png",
		"res://texture/cloud/Cloud Day 08.png",
		"res://texture/cloud/Cloud Day 09.png",
		"res://texture/cloud/Cloud Day 10.png",
		"res://texture/cloud/Cloud Day 11.png",
		"res://texture/cloud/Cloud Day 12.png",
		"res://texture/cloud/Cloud Day 13.png",
		"res://texture/cloud/Cloud Day 14.png",
		"res://texture/cloud/Cloud Day 15.png",
		"res://texture/cloud/Cloud Day 16.png",
		"res://texture/cloud/Cloud Day 17.png",
		"res://texture/cloud/Cloud Day 18.png",
		"res://texture/cloud/Cloud Day 19.png",
		"res://texture/cloud/Cloud Day 20.png",
		"res://texture/cloud/Cloud Day 21.png",
		"res://texture/cloud/Cloud Day 22.png",
		"res://texture/cloud/Cloud Day 23.png",
		"res://texture/cloud/Cloud Day 24.png",
		"res://texture/cloud/Cloud Day 25.png",
		"res://texture/cloud/Cloud Day 26.png",
		"res://texture/cloud/Cloud Day 27.png",
		"res://texture/cloud/Cloud Day 28.png",
		"res://texture/cloud/Cloud Day 29.png",
		"res://texture/cloud/Cloud Day 30.png",
	],
	"Night":
	[
		"res://texture/cloud/Cloud Night 01.png",
		"res://texture/cloud/Cloud Night 02.png",
		"res://texture/cloud/Cloud Night 03.png",
		"res://texture/cloud/Cloud Night 04.png",
		"res://texture/cloud/Cloud Night 05.png",
		"res://texture/cloud/Cloud Night 06.png",
		"res://texture/cloud/Cloud Night 07.png",
	]
}

const STARS = [
	"res://texture/stars/Star 01.png",
	"res://texture/stars/Star 02.png",
	"res://texture/stars/Star 03.png",
	"res://texture/stars/Star 04.png",
]
