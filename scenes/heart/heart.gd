class_name Heart extends Area2D

@export var heal_amt: int = 1

var _collectable: bool = true

@onready var removal_timer: Timer = $RemovalTimer
@onready var sound: AudioStreamPlayer2D = $Sound


func remove() -> void:
	hide()
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if PlayerManager.player_is_at_full_hearts():
		return
	if _collectable:
		_collectable = false
		PlayerManager.increase_hearts(heal_amt)
		SignalManager.on_heart_collected.emit()
		removal_timer.start()
		SoundManager.play_clip(sound, SoundManager.SOUND_COIN)


func _on_removal_timer_timeout() -> void:
	queue_free()
