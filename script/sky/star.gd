extends Sprite

# const
const SCREEN_WIDTH = 900
const DEFAULT_POS_X = SCREEN_WIDTH + 10
const SPEED_X_MIN = 20
const SPEED_X_MAX = 30
const OFFSET_Y_MIN = 50
const OFFSET_Y_MAX = 250

# local var
var speedX
var cloudType = "Day"
var starIdx: int


# Called when the node enters the scene tree for the first time.
func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_cloud_type()
	if cloudType == "Night":
		set_physics_process(true)
		self.visible = true
		__reset_star()
		self.position.x = rand_range(-10, SCREEN_WIDTH + 10)
	else:
		set_physics_process(false)
		self.visible = false


func __reset_cloud_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.background:
		push_warning("Wrong NFT cloud traits.")
		return

	if not K.DATA_BACKGROUND.has(MgrNft.NFT_TRAITS.background):
		push_warning("Not found background id, " + MgrNft.NFT_TRAITS.background)
		return

	cloudType = K.DATA_BACKGROUND.get(MgrNft.NFT_TRAITS.background).cloud_type


func __reset_star():
	speedX = rand_range(SPEED_X_MIN, SPEED_X_MAX)
	self.position.x = DEFAULT_POS_X
	self.position.y = rand_range(OFFSET_Y_MIN, OFFSET_Y_MAX)
	starIdx = randi() % K.STARS.size()
	var res = K.STARS[starIdx]
	self.texture = load(res)


func _physics_process(dt):
	move(dt)


func move(dt):
	self.position.x -= speedX * dt
	if self.position.x < 0:
		self.position.x += SCREEN_WIDTH
