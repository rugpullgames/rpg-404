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
	pass  # Replace with function body.


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_foreground_texture()


func __reset_foreground_texture():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.floor:
		push_warning("Wrong NFT floor traits.")
		return


func _physics_process(dt):
	__move(dt)


func __move(dt):
	self.position.x -= SPEED_X * dt
	self.position.x = fmod(self.position.x + SCREEN_WIDTH_EXT, SCREEN_WIDTH_EXT)
