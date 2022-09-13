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
	_reset_strxnger_body_type()


func _reset_strxnger_body_type() -> void:
	if MgrNft.is_rpg404():
		visible = false
	elif MgrNft.is_strxngers():
		visible = true
	else:
		push_warning("Wrong NFT Strxngers body traits.")
