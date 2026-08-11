class_name Ston extends Area2D

var _collectable = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sprite_2d: Sprite2D = $Sprite2D


func _on_area_entered(_area: Area2D) -> void:
	if _collectable:
		_collectable = false
		collision_shape_2d.disabled = true
		SoundManager.play_clip(sound, SoundManager.SOUND_EXTRA_LIFE)
		animation_player.play("float")
		PlayerManager.gain_extra_life()
