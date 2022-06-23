# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Area2D

# const 
const SCREEN_WIDTH = 900
const DEFAULT_POS_X = SCREEN_WIDTH * 2
const SPEED_X = 200

func _ready():
    __bind_events()

func __bind_events():
    var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
    pass