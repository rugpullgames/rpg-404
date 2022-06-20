extends Sprite

# const
const SCREEN_WIDTH = 900
const DEFAULT_POS_X = SCREEN_WIDTH * 2
const SPEED_X_MIN = 150
const SPEED_X_MAX = 300
const OFFSET_Y_MIN = 50
const OFFSET_Y_MAX = 250

# local var
var speedX
var cloudType = "Night"
var cloudIdx: int


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	self.position.x = rand_range(-SCREEN_WIDTH, SCREEN_WIDTH)


func reset():
	if cloudIdx:
		G.cloudUsed[cloudIdx] = false
	speedX = rand_range(SPEED_X_MIN, SPEED_X_MAX)
	self.position.x = DEFAULT_POS_X
	self.position.y = rand_range(OFFSET_Y_MIN, OFFSET_Y_MAX)
	cloudIdx = randi() % K.CLOUDS[cloudType].size()
	while G.cloudUsed.get(cloudIdx) and G.cloudUsed.size() < K.CLOUDS[cloudType].size():
		cloudIdx = randi() % K.CLOUDS[cloudType].size()
	G.cloudUsed[cloudIdx] = true
	var res = K.CLOUDS[cloudType][cloudIdx]
	self.texture = load(res)


func _physics_process(dt):
	move(dt)


func move(dt):
	self.position.x -= speedX * dt
	if self.position.x < -SCREEN_WIDTH:
		reset()
