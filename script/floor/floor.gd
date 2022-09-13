# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

# const
const SCREEN_WIDTH = K.SCREEN_WIDTH
const SCREEN_WIDTH_EXT = SCREEN_WIDTH + 300
const SPEED_X = K.SPEED_X

### default


# Called when the node enters the scene tree for the first time.
func _ready():
	_bind_events()


func _process(dt):
	if G.game_state != K.GameState.RUNNING:
		return
	_move(dt)


### private


func _bind_events():
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)


func _reset():
	_reset_foreground_texture()


func _reset_foreground_texture():
	if MgrNft.is_rpg404() and MgrNft.NFT_TRAITS.floor:
		var res = "res://texture/floor/%s.png" % [MgrNft.NFT_TRAITS.floor]
		self.texture = load(res)
	elif MgrNft.is_strxngers():
		var res = "res://texture/strxngers/floor_strxngers_01.png"
		self.texture = load(res)
	else:
		push_warning("Wrong NFT floor traits.")



func _move(dt):
	if G.game_state != K.GameState.RUNNING:
		return

	self.position.x -= SPEED_X * G.factor * dt
	self.position.x = fmod(self.position.x + SCREEN_WIDTH_EXT, SCREEN_WIDTH_EXT)
