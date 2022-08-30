# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Sprite

# const
const SCREEN_WIDTH = K.SCREEN_WIDTH
const DEFAULT_POS_X = SCREEN_WIDTH * 2
const SPEED_X_MIN = K.SPEED_X * 0.5
const SPEED_X_MAX = K.SPEED_X
const OFFSET_Y_MIN = 50
const OFFSET_Y_MAX = 250

# local var
var speedX = 0
var cloudType = "Day"
var cloudIdx: int


# Called when the node enters the scene tree for the first time.
func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_cloud_type()
	__reset_cloud()
	self.position.x = rand_range(-SCREEN_WIDTH, SCREEN_WIDTH)


func __reset_cloud_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.background:
		push_warning("Wrong NFT cloud traits.")
		return

	if not K.DATA_BACKGROUND.has(MgrNft.NFT_TRAITS.background):
		push_warning("Not found background id, " + MgrNft.NFT_TRAITS.background)
		return

	cloudType = K.DATA_BACKGROUND.get(MgrNft.NFT_TRAITS.background).cloud_type


func __reset_cloud():
	if cloudIdx:
		G.cloud_used[cloudIdx] = false
	speedX = rand_range(SPEED_X_MIN, SPEED_X_MAX)
	self.position.x = DEFAULT_POS_X
	self.position.y = rand_range(OFFSET_Y_MIN, OFFSET_Y_MAX)
	cloudIdx = randi() % K.CLOUDS[cloudType].size()
	while G.cloud_used.get(cloudIdx) and G.cloud_used.size() < K.CLOUDS[cloudType].size():
		cloudIdx = randi() % K.CLOUDS[cloudType].size()
	G.cloud_used[cloudIdx] = true
	var res = K.CLOUDS[cloudType][cloudIdx]
	self.texture = load(res)


func _process(dt):
	if G.game_state == K.GameState.RUNNING:
		__move(dt)


func __move(dt):
	self.position.x -= speedX * G.factor * dt
	if self.position.x < -SCREEN_WIDTH:
		__reset_cloud()
