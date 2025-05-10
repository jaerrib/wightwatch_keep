extends Heart

const GRAVITY: float = 160.0
const JUMP: float = -60.0

var _collectable: bool = false
var _speed_y: float = JUMP
var _start_y: float

@onready var collection_timer: Timer = $CollectionTimer


func _ready() -> void:
	_start_y = position.y
	collection_timer.start()


func _process(delta: float) -> void:
	position.y += _speed_y * delta
	_speed_y += GRAVITY * delta
	if position.y >= _start_y:
		set_process(false)


func _on_area_entered(area: Area2D) -> void:
	if _collectable:
		PlayerManager.increase_hearts(heal_amt)
		SignalManager.on_heart_collected.emit()
		removal_timer.start()
		SoundManager.play_clip(sound, SoundManager.SOUND_COIN)


func _on_collection_timer_timeout() -> void:
	_collectable = true
