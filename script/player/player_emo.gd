# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

const SHOW_TIME = 0.3

var tt = 0


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_ready", self, "hide_emo")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_end", self, "show_emo")
	assert(error_code == OK, error_code)


func __reset():
	__reset_emo_type()
	hide_emo()


func __reset_emo_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.emo:
		push_warning("Wrong NFT emo traits.")
		return
	var res = "res://texture/emo/%s.png" % [MgrNft.NFT_TRAITS.emo]
	self.texture = load(res)


func _process(dt):
	if G.gameState != K.GameState.RUNNING:
		return

	if self.visible:
		tt += dt

	if tt >= SHOW_TIME:
		hide_emo()
		tt = 0


func show_emo():
	self.visible = true


func hide_emo():
	self.visible = false
