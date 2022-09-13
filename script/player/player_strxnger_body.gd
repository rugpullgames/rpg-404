# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi
extends Sprite

const TMP_BODY_FILE = "user://strxnger_body.png"

onready var HTTPRequest: HTTPRequest = $HTTPRequest

### default


func _ready():
	_bind_events()


### private


func _bind_events() -> void:
	var error_code = Events.connect("update_traits", self, "_reset")
	assert(error_code == OK, error_code)


func _reset() -> void:
	_reset_strxnger_body_type()


func _reset_strxnger_body_type() -> void:
	if MgrNft.is_rpg404():
		visible = false
	elif MgrNft.is_strxngers():
		visible = true
		_download_body_texture()
	else:
		push_warning("Wrong NFT Strxngers body traits.")


func _download_body_texture() -> void:
	if OS.get_name() != "HTML5":
		HTTPRequest.set_use_threads(true)
	HTTPRequest.set_download_file(TMP_BODY_FILE)

	var image_url = "https://rpg404.com/nft/strxngers/%s.png" % [MgrNft.nft_strxnger_token_id]
	var error_code = HTTPRequest.request(image_url)
	if error_code != OK:
		push_error("An error occurred in the HTTP request.")


func _on_HTTPRequest_request_completed(result, response_code, _headers, _body) -> void:
	if result == OK:
		if response_code == 200:
			var texture = ImageTexture.new()
			var image = Image.new()
			image.load(TMP_BODY_FILE)
			texture.create_from_image(image, 1)
			self.texture = texture
		else:
			push_warning("response_code = %s" % response_code)
	else:
		push_warning("result = %s" % result)
