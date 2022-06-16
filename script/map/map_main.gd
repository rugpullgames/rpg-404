extends Node

onready var label = $Control/Label

func _ready():
	print('TEST!')
	if OS.has_feature('JavaScript'):
		var nftData = JavaScript.eval("""
			console.log('The JavaScript singleton is available')
			var strMetadata = JSON.stringify(window.nftMetadata)
			strMetadata
		""")
		if nftData and not nftData.empty():
			var p = JSON.parse(nftData)
			if typeof(p.result) == TYPE_DICTIONARY:
				label.text = 'Character: %s\nDescription: %s' % [p.result.name, p.result.description] 
			else:
				push_error("Unexpected results.")
		else:
			push_error("Metadata is NULL.")
	else:
		print("The JavaScript singleton is NOT available")


