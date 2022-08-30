# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

# const
const FPS = 4
const OFFSET_Y = 5
const DEFAULT_TIME_FPS = 1.0 / FPS
const FPS_FACTOR = 0.8

# public
var moving = false

# local var
var _time_per_frame: float = DEFAULT_TIME_FPS
var _tt = 0

# default


func _ready():
	_bind_events()


func _process(dt):
	if G.game_state != K.GameState.RUNNING:
		return

	if !moving:
		# jumping
		self.position.y = 0
		return

	_time_per_frame = DEFAULT_TIME_FPS / ((G.factor - 1) * FPS_FACTOR + 1)
	_tt += dt
	if _tt > _time_per_frame:
		_tt -= _time_per_frame
		if self.position.y != 0:
			self.position.y = 0
		else:
			self.position.y = OFFSET_Y


# private


func _bind_events():
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)


func _reset():
	_reset_weapon_type()
	_reset_time_fps()
	_tt = 0


func _reset_time_fps():
	_time_per_frame = DEFAULT_TIME_FPS


func _reset_weapon_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.weapon:
		push_warning("Wrong NFT weapon traits.")
		return
	var res = "res://texture/weapon/%s.png" % [MgrNft.NFT_TRAITS.weapon]
	self.texture = load(res)
