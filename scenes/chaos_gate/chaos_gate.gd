extends Area2D

@onready var sound: AudioStreamPlayer2D = $Sound


func _ready() -> void:
	sound.connect("finished", _on_sound_finished)


func _on_area_entered(area: Area2D) -> void:
	for mv in get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP):
		mv.set_process(false)
		mv.set_physics_process(false)
	SoundManager.play_clip(sound, SoundManager.SOUND_WARP_GATE)


func _on_sound_finished() -> void:
	GameManager.use_chaos_gate()
