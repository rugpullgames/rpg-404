# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi
extends Node

enum NftBrand { NULL, RPG404, STRXNGERS }

const NFT_RPGT404_META_TEST = {
	"attributes":
	[
		{"trait_type": "Music", "value": "Mozart Rondo Alla Turca 03"},
		{"trait_type": "Background", "value": "Light Blue Sky 01"},
		{"trait_type": "Foreground", "value": "Base Floor"},
		{"trait_type": "Barrier", "value": "Cube Yellow 02"},
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

const NFT_STRXNGERS_TOKEN_ID_TEST = 10
const NFT_STRXNGERS_MAX = 6666

var nft_brand = NftBrand.STRXNGERS
var nft_rpg404_meta = NFT_RPGT404_META_TEST  # Metadata JSON
var nft_strxnger_token_id: int = NFT_STRXNGERS_TOKEN_ID_TEST  # test
var NFT_TRAITS = null  # Traits Dict

### public


func reload_nft():
	_load_nft_metadata()
	if nft_rpg404_meta:
		_get_traits()
		_update_metadata_traits()
		Events.emit_signal("game_ready")
	elif nft_strxnger_token_id:
		_update_metadata_traits()
		Events.emit_signal("game_ready")
	else:
		push_warning("Metadata is NULL.")


func is_rpg404() -> bool:
	return nft_brand == NftBrand.RPG404 and NFT_TRAITS


func is_strxngers() -> bool:
	return (
		nft_brand == NftBrand.STRXNGERS
		and nft_strxnger_token_id > 0
		and nft_strxnger_token_id <= NFT_STRXNGERS_MAX
	)


### private


func _load_nft_metadata():
	if OS.has_feature("JavaScript"):
		print("Game load NFT metadata")
		var nft_data = JavaScript.eval(
			"""
			console.log('The JavaScript singleton is available');
			var strMetadata = JSON.stringify(window.nftMetadata);
			strMetadata;
			"""
		)
		if nft_data and not nft_data.empty():
			var p = JSON.parse(nft_data)
			if typeof(p.result) == TYPE_DICTIONARY:
				#TODO: set nft_brand
				nft_brand = NftBrand.RPG404
				nft_rpg404_meta = p.result
			else:
				push_warning("Unexpected results.")
		else:
			push_warning("Metadata is NULL.")
	else:
		push_warning("The JavaScript singleton is NOT available")


func _get_traits():
	if not nft_rpg404_meta:
		return

	NFT_TRAITS = {}
	for trait in nft_rpg404_meta.attributes:
		NFT_TRAITS[trait.trait_type.to_lower()] = trait.value.to_lower().replace(" ", "_")


func _update_metadata_traits():
	Events.emit_signal("update_traits")
