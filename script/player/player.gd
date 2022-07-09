# @copyright Rug Pull Games
# @see Rug Pull Games: https://rug-pull.games/
# @see RPG 404: https://rpg404.com/
# @author endaye.eth, Fried Egg Fendi

extends KinematicBody2D

# nodes
onready var Emo: Sprite = $SprEmo
onready var Head: Sprite = $SprHead
onready var Weapon: Sprite = $SprWeapon
onready var Pants: AnimatedSprite = $AsprPants
onready var AudioJump: AudioStreamPlayer2D = $AudioJump
onready var AudioDie: AudioStreamPlayer2D = $AudioDie
onready var AudioPowerUp: AudioStreamPlayer2D = $AudioPowerUp

# const
const GRAVITY = 1500
const JUMP_FORCE = 400
const LONG_JUMP_TIME = 0.1
const WEAPON_JUMP_UP_OFFSET = Vector2(-10, 10)
const WEAPON_JUMP_DOWN_OFFSET = Vector2(10, 15)
const WEAPON_MOVE_OFFSET = Vector2()

# local variables
var velocity = Vector2()
var longJump = false
var tt = 0


func _ready():
	__bind_events()


func __bind_events():
	var error_code = Events.connect("game_end", self, "__player_die")
	assert(error_code == OK, error_code)


func _physics_process(dt):
	if G.gameState == K.GameState.READY:
		Pants.playing = true
		return
	elif G.gameState == K.GameState.END:
		Pants.playing = false
		return
	elif G.gameState == K.GameState.RUNNING:
		velocity.y += dt * GRAVITY

		if is_on_floor():
			longJump = false
			tt = 0

		if Input.is_action_pressed("ui_accept") and is_on_floor():
			velocity.y = -JUMP_FORCE
			Emo.show_emo()
			if G.sfxAudio:
				AudioJump.play()

		if Input.is_action_pressed("ui_accept") and not longJump and tt >= LONG_JUMP_TIME:
			velocity.y = -JUMP_FORCE * 1.3
			longJump = true
			if G.sfxAudio and !AudioJump.is_playing():
				AudioJump.play()

		velocity = move_and_slide(velocity, Vector2.UP)

		if Input.is_action_pressed("ui_accept"):
			tt += dt

		if is_on_floor():
			# move
			Pants.playing = true
			Head.moving = true
			Weapon.moving = true
			Weapon.offset = WEAPON_MOVE_OFFSET
		else:
			# jump
			Pants.playing = false
			Pants.frame = 0 if velocity.y < 0 else 1
			Head.moving = false
			Weapon.moving = false
			Weapon.offset = WEAPON_JUMP_UP_OFFSET if velocity.y < 0 else WEAPON_JUMP_DOWN_OFFSET

			# prevent player going out of screen
			# prevent player gDOWNng out of screen
		self.position.y = clamp(self.position.y, 0, K.SCREEN_HEIGHT)


func __player_die():
	__play_audio_die()


func __play_audio_die():
	if G.sfxAudio:
		AudioDie.play()


func play_audio_power_up():
	if G.sfxAudio:
		AudioPowerUp.play()
