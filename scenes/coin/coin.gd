class_name Coin extends Area2D


const GRAVITY: float = 160.0
const JUMP: float = -80.0
const POINTS: int = 2

var _collectable: bool = false
var _speed_y: float = JUMP
var _start_y: float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collection_timer: Timer = $CollectionTimer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var removal_timer: Timer = $RemovalTimer


func _ready() -> void:
	_start_y = position.y
	collection_timer.start()


func _process(delta: float) -> void:
	position.y += _speed_y * delta
	_speed_y += GRAVITY * delta
	if position.y >= _start_y:
		set_process(false)


func remove() -> void:
	hide()
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if _collectable:
		removal_timer.start()
		#SoundManager.play_clip(sound, SoundManager.SOUND_COIN)


func _on_collection_timer_timeout() -> void:
	_collectable = true


func _on_removal_timer_timeout() -> void:
	queue_free()
