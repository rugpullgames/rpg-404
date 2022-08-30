# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

# const
const SPAWN_TIME_MIN = 2
const SPAWN_TIME_MAX = 3
const SPAWN_TIME_FACTOR = 0.5
const DEFAULT_POS_X = 1000

# local var
var tt = 0
var nextTime = __get_next_time(1)
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
	nextTime = __get_next_time(1)


func __reset_barrier_textures():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.barrier:
		push_warning("Wrong NFT barrier traits.")
		return

	textures = []
	for n in range(1, 6):
		var res = (
			"res://texture/barrier/%s/%s_0%s.png"
			% [MgrNft.NFT_TRAITS.barrier, MgrNft.NFT_TRAITS.barrier, n]
		)
		var texture = load(res)

		textures.append(texture)


func __disable_all_barriers():
	for brr in self.get_children():
		brr.visible = false
		brr.set_process(false)
		brr.position.x = DEFAULT_POS_X


func _process(dt):
	if G.game_state == K.GameState.READY:
		tt = 0
	elif G.game_state == K.GameState.RUNNING:
		tt += dt
		if tt >= nextTime:
			__spawn_barrier()
			tt = 0
			nextTime = __get_next_time()


func __spawn_barrier():
	for brr in self.get_children():
		if not brr.visible:
			brr.set_process(true)
			var idx = randi() % textures.size()
			brr.reset(textures[idx])
			break


func __get_next_time(factor = G.factor):
	return rand_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX) / ((factor - 1) * SPAWN_TIME_FACTOR + 1)
