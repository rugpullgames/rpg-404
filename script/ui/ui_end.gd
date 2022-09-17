# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Control

# nodes
onready var Version: Label = $BtnGodot/Version

### default


func _ready():
	_bind_events()
	self.visible = false
	Version.text = "Game " + V.VERSION


func _process(_dt):
	if G.game_state == K.GameState.END:
		_check_input()


### private


func _bind_events():
	var error_code = Events.connect("game_ready", self, "_hide_gui")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_end", self, "_show_gui")
	assert(error_code == OK, error_code)


func _show_gui():
	self.visible = true


func _hide_gui():
	self.visible = false


func _check_input():
	if Input.is_action_just_pressed("ui_accept"):
		_restart_game()


func _restart_game():
	Events.emit_signal("game_ready")


func _on_BtnRestart_pressed():
	_restart_game()


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
		+ "%20on&url=https:%2F%2Frpg404.com%2F"
		+ "%0A&hashtags=rpg404,rpg,indiegame,indiedev,IndieGameDev,pixelart,Mozart,GodotEngine,web3,nft,gamefi"
		+ "%0A&via=rug_pull_games"
	)
	if MgrNft.is_strxngers():
		shareLink = (
			"https://twitter.com/intent/tweet?text=My%20%40StrxngersNFT%20record%20is%20"
			+ str(G.score)
			+ "%20on&url=https:%2F%2Frpg404.com%2F"
			+ "%0A&hashtags=cc0,rpg404,strxngers,indiegame,pixelart,GodotEngine,web3,nft,gamefi"
			+ "%0A&via=rug_pull_games"
		)

	var error_code = OS.shell_open(shareLink)
	assert(error_code == OK, error_code)
