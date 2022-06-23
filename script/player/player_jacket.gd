# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_jacket_type()


func __reset_jacket_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.jacket:
		push_warning("Wrong NFT jacket traits.")
		return
	var res = "res://texture/jacket/%s.png" % [MgrNft.NFT_TRAITS.jacket]
	self.texture = load(res)
