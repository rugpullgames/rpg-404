# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Control

onready var BtnBgm: Button = $BtnBgmAudio
onready var BtnSfx: Button = $BtnSfxAudio


func _ready():
	__update_ui()


func __update_ui():
	BtnBgm.text = "BGM: On" if G.bgmAudio else "BGM: Off"
	BtnSfx.text = "SFX: On" if G.sfxAudio else "SFX: Off"


func _on_BtnBgmAudio_pressed():
	G.bgmAudio = !G.bgmAudio
	__update_ui()


func _on_BtnSfxAudio_pressed():
	G.sfxAudio = !G.sfxAudio
	__update_ui()
