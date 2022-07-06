# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Control


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("game_ready", self, "__hide_gui")
	assert(error_code == OK, error_code)
	error_code = Events.connect("game_end", self, "__show_gui")
	assert(error_code == OK, error_code)


func __show_gui():
	self.visible = true


func __hide_gui():
	self.visible = false


func _physics_process(dt):
	if G.gameState == K.GameState.END:
		__check_input(dt)


func __check_input(dt):
	if Input.is_action_just_pressed("ui_accept"):
		__restart_game()


func __restart_game():
	Events.emit_signal("game_ready")


func _on_BtnRestart_pressed():
	__restart_game()


func _on_BtnCopyright_pressed():
	OS.shell_open("https://rug-pull.games/")


func _on_BtnGodot_pressed():
	OS.shell_open("https://godotengine.org")