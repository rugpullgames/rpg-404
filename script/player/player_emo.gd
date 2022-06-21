extends Sprite


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_emo_type()


func __reset_emo_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.emo:
		push_warning("Wrong NFT emo traits.")
		return
	var res = "res://texture/emo/%s.png" % [MgrNft.NFT_TRAITS.emo]
	print(res)
	self.texture = load(res)
