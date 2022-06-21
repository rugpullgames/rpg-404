extends Sprite

const FPS = 4
const OFFSET_Y = 5

var timePerFrame: float = 1.0 / FPS
var tt = 0


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_weapon_type()
	tt = 0


func __reset_weapon_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.weapon:
		push_warning("Wrong NFT weapon traits.")
		return
	var res = "res://texture/weapon/%s.png" % [MgrNft.NFT_TRAITS.weapon]
	self.texture = load(res)


func _physics_process(dt):
	tt += dt
	if tt > timePerFrame:
		tt -= timePerFrame
		if self.position.y != 0:
			self.position.y = 0
		else:
			self.position.y = OFFSET_Y
