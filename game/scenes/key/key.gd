extends Area2D

@onready var removal_timer: Timer = $RemovalTimer
@onready var sound: AudioStreamPlayer2D = $Sound


func _on_area_entered(area: Area2D) -> void:
	removal_timer.start()
	SignalManager.on_key_collected.emit()
	SoundManager.play_clip(sound, SoundManager.SOUND_KEY)


func _on_removal_timer_timeout() -> void:
	queue_free()
