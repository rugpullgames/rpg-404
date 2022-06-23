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
	__reset_head_type()


func __reset_head_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.head:
		push_warning("Wrong NFT head traits.")
		return
	var res = "res://texture/head/%s.png" % [MgrNft.NFT_TRAITS.head]
	self.texture = load(res)
