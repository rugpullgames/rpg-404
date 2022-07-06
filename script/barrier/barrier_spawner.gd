# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# const
const SPAWN_TIME_MIN = 2
const SPAWN_TIME_MAX = 3
const DEFAULT_POS_X = 1000

# local var
var tt = 0
var nextTime = rand_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX)
var textures = []


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_ready", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_barrier_textures()
	__disable_all_barriers()


func __reset_barrier_textures():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.barrier:
		push_warning("Wrong NFT barrier traits.")
		return

	textures = []
	for n in range(1, 6):
		var res = (
			"res://texture/barrier/%s/%s 0%s.png"
			% [MgrNft.NFT_TRAITS.barrier, MgrNft.NFT_TRAITS.barrier, n]
		)
		var texture = load(res)

		textures.append(texture)


func __disable_all_barriers():
	for brr in self.get_children():
		brr.visible = false
		brr.set_physics_process(false)
		brr.position.x = DEFAULT_POS_X


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	tt += dt
	if tt >= nextTime:
		__spawn_barrier()
		tt = 0
		nextTime = rand_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX)


func __spawn_barrier():
	for brr in self.get_children():
		if not brr.visible:
			brr.set_physics_process(true)
			var idx = randi() % textures.size()
			brr.reset(textures[idx])
			break
