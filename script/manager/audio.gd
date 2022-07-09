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


func _ready():
	__update_ui()


func __update_ui():
	BtnBgm.icon = RES_BGM_ON if G.bgmAudio else RES_BGM_OFF
	BtnSfx.icon = RES_SFX_ON if G.sfxAudio else RES_SFX_OFF


func _on_BtnBgmAudio_pressed():
	G.bgmAudio = ! G.bgmAudio
	__update_ui()


func _on_BtnSfxAudio_pressed():
	G.sfxAudio = ! G.sfxAudio
	__update_ui()
