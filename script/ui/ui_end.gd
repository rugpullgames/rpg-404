# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Control

# nodes
onready var Version: Label = $BtnGodot/Version


func _ready():
	__bind_events()
	self.visible = false
	Version.text = "Game " + V.VERSION


func __bind_events():
	var error_code = Events.connect("game_ready", self, "__hide_gui")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_end", self, "__show_gui")
	assert(error_code == OK, error_code)


func __show_gui():
	self.visible = true


func __hide_gui():
	self.visible = false


func _process(_dt):
	if G.gameState == K.GameState.END:
		__check_input()


func __check_input():
	if Input.is_action_just_pressed("ui_accept"):
		__restart_game()


func __restart_game():
	Events.emit_signal("game_ready")


func _on_BtnRestart_pressed():
	__restart_game()


func _on_BtnSelect_pressed():
	JavaScript.eval("parent.location.reload();")


func _on_BtnCopyright_pressed():
	var error_code = OS.shell_open("https://rug-pull.games/")
	assert(error_code == OK, error_code)


func _on_BtnGodot_pressed():
	var error_code = OS.shell_open("https://godotengine.org")
	assert(error_code == OK, error_code)


func _on_BtnShare_pressed():
	print("Share score with Twitter. Don't cheat!")
	var shareLink = (
		"https://twitter.com/intent/tweet?text=My%20record%20is%20"
		+ str(G.score)
		+ "%20in&url=rpg404.com%0A&hashtags=rpg404,rpg,indiegame,indiedev,IndieGameDev,pixelart,Mozart,GodotEngine,web3,nft,gamefi%0A&via=rug_pull_games"
	)
	var error_code = OS.shell_open(shareLink)
	assert(error_code == OK, error_code)
