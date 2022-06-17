# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

var NFT_META = null


func _ready():
	load_nft_metadata()


func load_nft_metadata():
	if OS.has_feature("JavaScript"):
		print("Game load NFT metadata")
		var nftData = JavaScript.eval(
			"""
			console.log('The JavaScript singleton is available')
			var strMetadata = JSON.stringify(window.nftMetadata)
			strMetadata
		    """
		)
		if nftData and not nftData.empty():
			var p = JSON.parse(nftData)
			if typeof(p.result) == TYPE_DICTIONARY:
				NFT_META = p.result
			else:
				push_error("Unexpected results.")
		else:
			push_error("Metadata is NULL.")
	else:
		print("The JavaScript singleton is NOT available")
