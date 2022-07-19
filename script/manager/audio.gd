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
var resBgm = "mute.ogg"
export(NodePath) var pathToBgm
var AudioBgm: AudioStreamPlayer2D


func _ready():
	AudioBgm = get_node(pathToBgm)
	__update_ui()
	__bind_events()


func __bind_events():
	var error_code = Events.connect("update_traits", self, "__reset")
	assert(error_code == OK, error_code)


func __reset():
	__reset_bgm_type()


func __reset_bgm_type():
	if not MgrNft.NFT_TRAITS or not MgrNft.NFT_TRAITS.music:
		push_warning("Wrong NFT cloud traits.")
		return

	if not K.DATA_MUSIC.has(MgrNft.NFT_TRAITS.music):
		push_warning("Not found music id, " + MgrNft.NFT_TRAITS.music)
		return

	resBgm = K.DATA_MUSIC.get(MgrNft.NFT_TRAITS.music).res_bgm
	AudioBgm.stream = load("res://audio/bgm/" + resBgm)


func __update_ui():
	BtnBgm.icon = RES_BGM_ON if G.bgmAudio else RES_BGM_OFF
	BtnSfx.icon = RES_SFX_ON if G.sfxAudio else RES_SFX_OFF


func _on_BtnBgmAudio_pressed():
	G.bgmAudio = !G.bgmAudio
	__update_ui()


func _on_BtnSfxAudio_pressed():
	G.sfxAudio = !G.sfxAudio
	__update_ui()
