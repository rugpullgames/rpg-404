# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

# const
const FPS = 8
const OFFSET_Y = 5
const DEFAULT_TIME_FPS = 1.0 / FPS
const FPS_FACTOR = 0.8

# local var
var timePerFrame: float = DEFAULT_TIME_FPS
var tt = 0
var moving = false


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_head_type()
	__reset_time_fps()
	tt = 0


func __reset_time_fps():
	timePerFrame = DEFAULT_TIME_FPS


func __reset_head_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.head:
		push_warning("Wrong NFT head traits.")
		return
	var res = "res://texture/head/%s.png" % [MgrNft.NFT_TRAITS.head]
	self.texture = load(res)


func _physics_process(dt):
	if G.gameState != K.GameState.RUNNING:
		return

	if ! moving:
		# jumping
		self.position.y = 0
		return

	timePerFrame = DEFAULT_TIME_FPS / ((G.factor - 1) * FPS_FACTOR + 1)
	tt += dt
	if tt > timePerFrame:
		tt -= timePerFrame
		if self.position.y != 0:
			self.position.y = 0
		else:
			self.position.y = OFFSET_Y
