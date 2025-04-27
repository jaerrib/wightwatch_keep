extends Area2D


@onready var sound: AudioStreamPlayer2D = $Sound


func _on_area_entered(area: Area2D) -> void:
	SignalManager.on_key_collected.emit()
	#SoundManager.play_clip(sound, SoundManager.SOUND_KEY)
	queue_free()


func _on_sound_finished() -> void:
	#queue_free()
	pass
