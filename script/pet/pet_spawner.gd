# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# resorce
const SCENE_PET = preload("res://scene/pet/pet.tscn")

# const
const SPAWN_TIME_MIN = 3
const SPAWN_TIME_MAX = 8
const SPAWN_TIME_FACTOR = 0.5

# local var
var tt = 0
var nextTime = __get_next_time(1)
var textures = []


func _ready():
	var error_code = Events.connect("game_ready", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	nextTime = __get_next_time(1)


func _physics_process(dt):
	if G.gameState == K.GameState.READY:
		tt = 0
	elif G.gameState == K.GameState.RUNNING:
		tt += dt
		if tt >= nextTime:
			__spawn_pet()
			tt = 0
			nextTime = __get_next_time()


func __spawn_pet():
	var pet = SCENE_PET.instance()
	add_child(pet)


func __get_next_time(factor = G.factor):
	return rand_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX) / ((factor - 1) * SPAWN_TIME_FACTOR + 1)
