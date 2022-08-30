# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Control

# node
onready var BtnBgm: Button = $BtnBgmAudio
onready var BtnSfx: Button = $BtnSfxAudio

# resource
const RES_BGM_ON = preload("res://texture/ui/btn_game_bgm_on.png")
const RES_BGM_OFF = preload("res://texture/ui/btn_game_bgm_off.png")
const RES_SFX_ON = preload("res://texture/ui/btn_game_sfx_on.png")
const RES_SFX_OFF = preload("res://texture/ui/btn_game_sfx_off.png")

# local var
var _res_bgm = "mute.ogg"
export(NodePath) var path_to_bgm
var AudioBgm: AudioStreamPlayer2D


func _ready():
	AudioBgm = get_node(path_to_bgm)
	_update_ui()
	_bind_events()


func _bind_events():
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)


func _reset():
	_reset_bgm_type()


func _reset_bgm_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.music:
		push_warning("Wrong NFT cloud traits.")
		return

	if not K.DATA_MUSIC.has(MgrNft.NFT_TRAITS.music):
		push_warning("Not found music id, " + MgrNft.NFT_TRAITS.music)
		return

	_res_bgm = K.DATA_MUSIC.get(MgrNft.NFT_TRAITS.music)._res_bgm
	AudioBgm.stream = load("res://audio/bgm/" + _res_bgm)


func _update_ui():
	BtnBgm.icon = RES_BGM_ON if G.bgm_audio else RES_BGM_OFF
	BtnSfx.icon = RES_SFX_ON if G.sfx_audio else RES_SFX_OFF


func _on_BtnBgmAudio_pressed():
	G.bgm_audio = !G.bgm_audio
	_update_ui()


func _on_BtnSfxAudio_pressed():
	G.sfx_audio = !G.sfx_audio
	_update_ui()
