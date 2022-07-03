# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node


func _ready():
	__reset_floors()


func __reset_floors():
	var floors = self.get_children()
	floors[0].position.x = 0		
	floors[1].position.x = 300		
	floors[2].position.x = 600		
	floors[3].position.x = 900		
