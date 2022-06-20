extends Sprite

# const
const SCREEN_WIDTH = 900
const DEFAULT_POS_X = SCREEN_WIDTH * 2
const SPEED_X_MIN = 150
const SPEED_X_MAX = 300
const OFFSET_Y_MIN = 50
const OFFSET_Y_MAX = 250
const CLOUDS = {
	"Day":
	[
		"res://texture/cloud/Cloud Day 01.png",
		"res://texture/cloud/Cloud Day 02.png",
		"res://texture/cloud/Cloud Day 03.png",
		"res://texture/cloud/Cloud Day 04.png",
		"res://texture/cloud/Cloud Day 05.png",
		"res://texture/cloud/Cloud Day 06.png",
		"res://texture/cloud/Cloud Day 07.png",
		"res://texture/cloud/Cloud Day 08.png",
		"res://texture/cloud/Cloud Day 09.png",
		"res://texture/cloud/Cloud Day 10.png",
		"res://texture/cloud/Cloud Day 11.png",
		"res://texture/cloud/Cloud Day 12.png",
		"res://texture/cloud/Cloud Day 13.png",
		"res://texture/cloud/Cloud Day 14.png",
		"res://texture/cloud/Cloud Day 15.png",
		"res://texture/cloud/Cloud Day 16.png",
		"res://texture/cloud/Cloud Day 17.png",
		"res://texture/cloud/Cloud Day 18.png",
		"res://texture/cloud/Cloud Day 19.png",
		"res://texture/cloud/Cloud Day 20.png",
		"res://texture/cloud/Cloud Day 21.png",
		"res://texture/cloud/Cloud Day 22.png",
		"res://texture/cloud/Cloud Day 23.png",
		"res://texture/cloud/Cloud Day 24.png",
		"res://texture/cloud/Cloud Day 25.png",
		"res://texture/cloud/Cloud Day 26.png",
		"res://texture/cloud/Cloud Day 27.png",
		"res://texture/cloud/Cloud Day 28.png",
		"res://texture/cloud/Cloud Day 29.png",
		"res://texture/cloud/Cloud Day 30.png",
	],
	"Night":
	[
		"res://texture/cloud/Cloud Night 01.png",
		"res://texture/cloud/Cloud Night 02.png",
		"res://texture/cloud/Cloud Night 03.png",
		"res://texture/cloud/Cloud Night 04.png",
		"res://texture/cloud/Cloud Night 05.png",
		"res://texture/cloud/Cloud Night 06.png",
		"res://texture/cloud/Cloud Night 07.png",
	]
}

# local var
var speedX
var cloudType = "Day"


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	self.position.x = rand_range(-SCREEN_WIDTH, SCREEN_WIDTH)


func reset():
	speedX = rand_range(SPEED_X_MIN, SPEED_X_MAX)
	self.position.x = DEFAULT_POS_X
	self.position.y = rand_range(OFFSET_Y_MIN, OFFSET_Y_MAX)
	randomize()
	var rand_index: int = randi() % CLOUDS[cloudType].size()
	var res = CLOUDS[cloudType][rand_index]
	self.texture = load(res)


func _physics_process(dt):
	move(dt)


func move(dt):
	self.position.x -= speedX * dt
	if self.position.x < -SCREEN_WIDTH:
		reset()
