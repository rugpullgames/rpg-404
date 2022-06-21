extends AnimatedSprite

const ANIM_NAME = "default"


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_pants_type()


func __reset_pants_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.pants:
		push_warning("Wrong NFT pants traits.")
		return
	self.frames.clear(ANIM_NAME)
	var res1 = "res://texture/pants/%s_1.png" % [MgrNft.NFT_TRAITS.pants]
	var res2 = "res://texture/pants/%s_2.png" % [MgrNft.NFT_TRAITS.pants]
	var texture1 = load(res1)
	var texture2 = load(res2)
	self.frames.add_frame(ANIM_NAME, texture1, 0)
	self.frames.add_frame(ANIM_NAME, texture2, 1)
