# Version
# @see Hidden Moss: https://hiddenmoss.com/
# @see Miss. Peacock: https://miss-peacock.com/
# @author Yuancheng Zhang
extends Button

var image = Image.new()
var img
var img_exists = File.new()
var img_path = "user://twitter_share.png"
var tex = ImageTexture.new()

onready var Http: HTTPRequest = $HTTPRequest


func _ready():
	# Load image
	if img_exists.file_exists(img_path):
		image.load(img_path)
		tex.create_from_image(image)


func _send_https():
	# print("_send_https")
	var file = File.new()
	file.open(img_path, File.READ)
	var file_content = file.get_buffer(file.get_len())

	var use_ssl = true
	var imgbb_api = "https://api.imgbb.com/1/upload"
	var api_key = "7cf64b5f782a1afca533fd0d150c09cd"
	var img_name = "rpg404"
	var params = [
		"key=%s" % api_key,
		"name=%s" % img_name,
	]

	var body = PoolByteArray()
	body.append_array("\r\n--WebKitFormBoundaryRPG404".to_utf8())
	body.append_array(
		'\r\nContent-Disposition: form-data; name="image"; filename="rpg404.png"\r\n'.to_utf8()
	)
	body.append_array("Content-Type: image/png\r\n".to_utf8())
	body.append_array("Content-Transfer-Encoding: base64\r\n".to_utf8())
	body.append_array("\r\n".to_utf8())
	body.append_array(file_content)
	body.append_array("\r\n".to_utf8())
	body.append_array("--WebKitFormBoundaryRPG404--".to_utf8())
	body.append_array("\r\n".to_utf8())

	# print(body.size())
	var headers = [
		"Content-Type: multipart/form-data; charset=utf-8; boundary=WebKitFormBoundaryRPG404",
		"Content-Length: " + str(body.size()),
	]

	var url = imgbb_api + "?" + PoolStringArray(params).join("&")
	var error = Http.request_raw(url, headers, use_ssl, HTTPClient.METHOD_POST, body)
	if error != OK:
		print(error)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	# print("hahah")
	# print(result)
	# print(response_code)
	# print(headers)
	# print(body)
	var json = JSON.parse(body.get_string_from_utf8())

	var url = json.result.data.url_viewer
	print(url)
	var shareLink = (
		"https://twitter.com/intent/tweet?"
		+ "text="
		+ ("My record is %s." % str(G.score)).percent_encode()
		+ "&url="
		+ url.percent_encode()
		+ "&hashtags=rpg404,rpg,indiegame,indiedev,IndieGameDev,pixelart,Mozart,GodotEngine,web3,nft,gamefi"
		+ "\n".percent_encode()
		+ "&via=rug_pull_games"
	)

	print(shareLink)

	var error_code = OS.shell_open(shareLink)
	assert(error_code == OK, error_code)


func _on_BtnShare_pressed():
	# Get screenshot from screen
	img = get_viewport().get_texture().get_data()
	img.flip_y()

	# Save screenshot as png
	img.save_png(img_path)

	# Create texture for it
	tex.create_from_image(img)

	if img_exists.file_exists(img_path):
		_send_https()
