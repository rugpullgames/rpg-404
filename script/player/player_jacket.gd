# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

### default


func _ready():
	_bind_events()


### private


func _bind_events() -> void:
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)


func _reset() -> void:
	_reset_jacket_type()


func _reset_jacket_type() -> void:
	if MgrNft.is_rpg404() and MgrNft.NFT_TRAITS.jacket:
		var res = "res://texture/jacket/%s.png" % [MgrNft.NFT_TRAITS.jacket]
		self.texture = load(res)
		visible = true
	elif MgrNft.is_strxngers():
		visible = false
	else:
		push_warning("Wrong NFT jacket traits.")

