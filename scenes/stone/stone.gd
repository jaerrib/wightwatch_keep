class_name Ston extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sprite_2d: Sprite2D = $Sprite2D



func _on_area_entered(area: Area2D) -> void:
	collision_shape_2d.disabled = true
	SoundManager.play_clip(sound, SoundManager.SOUND_COIN)
	animation_player.play("float")
	#SignalManager.on_stone_collected.emit()
	PlayerManager.gain_extra_life()
