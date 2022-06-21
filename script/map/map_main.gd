# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

onready var label = $Control/Label


func _ready():
	MgrNft.reload_nft()
	print("Game Start")
