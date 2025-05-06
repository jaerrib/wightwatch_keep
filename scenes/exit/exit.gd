extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound: AudioStreamPlayer2D = $Sound


func _ready() -> void:
	monitoring = false
	animated_sprite_2d.play("idle")
	SignalManager.on_key_collected.connect(on_key_collected)
	
	
func on_key_collected() -> void:
	animated_sprite_2d.show()
	animated_sprite_2d.play("open")
	monitoring = true


func _on_area_entered(area: Area2D) -> void:
	#SoundManager.play_clip(sound, SoundManager.SOUND_EXIT)
	SignalManager.on_exit_reached.emit()
	GameManager.load_next_level_scene()
