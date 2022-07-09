# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

# const
const SCREEN_WIDTH = K.SCREEN_WIDTH
const SCREEN_WIDTH_EXT = SCREEN_WIDTH + 300
const SPEED_X = K.SPEED_X


# Called when the node enters the scene tree for the first time.
func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_foreground_texture()


func __reset_foreground_texture():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.floor:
		push_warning("Wrong NFT floor traits.")
		return
	var res = "res://texture/floor/%s.png" % [MgrNft.NFT_TRAITS.floor]
	self.texture = load(res)


func _process(dt):
	if G.gameState != K.GameState.RUNNING:
		return
	__move(dt)


func __move(dt):
	if G.gameState != K.GameState.RUNNING:
		return

	self.position.x -= SPEED_X * G.factor * dt
	self.position.x = fmod(self.position.x + SCREEN_WIDTH_EXT, SCREEN_WIDTH_EXT)
