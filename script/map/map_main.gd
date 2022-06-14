extends Node


func _ready():
	print('TEST!')
	if OS.has_feature('JavaScript'):
		var nftData = JavaScript.eval("""
			console.log('The JavaScript singleton is available')
			var test = {'b':12,'c':23,'d':{'e':34,'f':45}}
			var strTest = JSON.stringify(test)
			strTest
		""")
		print(nftData)
		var p = JSON.parse(nftData)
		print(typeof(p.result))
		if typeof(p.result) == TYPE_DICTIONARY:
			print(p.result.b)
		else:
			push_error("Unexpected results.")
	else:
		print("The JavaScript singleton is NOT available")


