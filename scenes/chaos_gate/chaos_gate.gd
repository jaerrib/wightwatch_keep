extends Area2D

@onready var sound: AudioStreamPlayer2D = $Sound


func _ready() -> void:
	sound.connect("finished", _on_sound_finished)


func _on_area_entered(area: Area2D) -> void:
	SoundManager.play_clip(sound, SoundManager.SOUND_COIN)


func _on_sound_finished() -> void:
	GameManager.use_chaos_gate()
