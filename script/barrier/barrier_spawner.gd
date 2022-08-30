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
var _tt = 0
var _next_time = _get_next_time(1)
var _textures = []


func _ready():
	_bind_events()


func _process(dt):
	if G.game_state == K.GameState.READY:
		_tt = 0
	elif G.game_state == K.GameState.RUNNING:
		_tt += dt
		if _tt >= _next_time:
			_spawn_barrier()
			_tt = 0
			_next_time = _get_next_time()


func _bind_events():
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_ready", self, "_reset")
	assert(error_code == OK, error_code)


func _reset():
	_reset_barrier_textures()
	_disable_all_barriers()
	_next_time = _get_next_time(1)


func _reset_barrier_textures():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.barrier:
		push_warning("Wrong NFT barrier traits.")
		return

	_textures = []
	for n in range(1, 6):
		var res = (
			"res://texture/barrier/%s/%s_0%s.png"
			% [MgrNft.NFT_TRAITS.barrier, MgrNft.NFT_TRAITS.barrier, n]
		)
		var texture = load(res)

		_textures.append(texture)


func _disable_all_barriers():
	for brr in self.get_children():
		brr.visible = false
		brr.set_process(false)
		brr.position.x = DEFAULT_POS_X


func _spawn_barrier():
	for brr in self.get_children():
		if not brr.visible:
			brr.set_process(true)
			var idx = randi() % _textures.size()
			brr.reset(_textures[idx])
			break


func _get_next_time(factor = G.factor):
	return rand_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX) / ((factor - 1) * SPAWN_TIME_FACTOR + 1)
