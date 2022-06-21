# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends Node

const NFT_META_TEST = {
	"attributes":
	[
		{"trait_type": "Background", "value": "Mid Blue Sky 01"},
		{"trait_type": "Foreground", "value": "Base Floor"},
		{"trait_type": "Barrier", "value": "Dead Goblins"},
		{"trait_type": "Floor", "value": "Floor 29"},
		{"trait_type": "Pants", "value": "Pants 13"},
		{"trait_type": "Jacket", "value": "Jacket 10"},
		{"trait_type": "Head", "value": "Head 16"},
		{"trait_type": "Weapon", "value": "Weapon 09"},
		{"trait_type": "Emo", "value": "Emo 07"},
		{"trait_type": "Pet", "value": "Space Ship"}
	],
	"date": 1655407034751,
	"description":
	"The first game of Rug Pull Games, RPG 404. Please visit rpg404.com to play this tiny game.",
	"dna": "94b508951b0b9b574224d15120a6c97adb898cfb",
	"edition": 1,
	"external_url": "https://rpg404.com/",
	"image": "ipfs://QmXg2eD8YNcfADVhpnci7SXCQrN1h1m1woPWh8hD8mUAkS/1.png",
	"name": "RPG404 #1",
	"twitter": "https://twitter.com/rug_pull_games",
	"website": "https://rug-pull.games/"
}

var NFT_META = NFT_META_TEST  # Metadata JSON
var NFT_TRAITS = null  # Traits Dict


func reload_nft():
	__load_nft_metadata()
	if NFT_META:
		__get_traits()
		__update_metadata_traits()
	else:
		push_warning("Metadata is NULL.")


func __load_nft_metadata():
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
				push_warning("Unexpected results.")
		else:
			push_warning("Metadata is NULL.")
	else:
		push_warning("The JavaScript singleton is NOT available")


func __get_traits():
	if not NFT_META:
		return

	NFT_TRAITS = {}
	for trait in NFT_META.attributes:
		NFT_TRAITS[trait.trait_type.to_lower()] = trait.value


func __update_metadata_traits():
	Events.emit_signal("update_traits")
