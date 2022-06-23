# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Label


func _ready():
	update_score()


func _process(_dt):
	update_score()


func update_score():
	self.text = str(G.score)
