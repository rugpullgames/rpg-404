# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends ColorRect

### default


func _ready():
	_bind_events()


### private


func _bind_events():
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)


func _reset():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.background:
		push_warning("Wrong NFT sky trait.")
		return

	if not K.DATA_BACKGROUND.has(MgrNft.NFT_TRAITS.background):
		push_warning("Not found background id, " + MgrNft.NFT_TRAITS.background)
		return

	var sky_color = K.DATA_BACKGROUND.get(MgrNft.NFT_TRAITS.background).sky_color
	self.color = Color(sky_color)
