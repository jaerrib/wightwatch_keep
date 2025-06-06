class_name PauseMenu extends Control

@onready var lives_label: Label = $VBoxContainer/HB/LivesLabel
@onready var sound: AudioStreamPlayer2D = $Sound


func _input(event) -> void:
	if event.is_action_pressed("back"):
		GameManager.load_main_scene()


func _notification(what: int) -> void:
	match what:
		Node.NOTIFICATION_PAUSED:
			hide()
		Node.NOTIFICATION_UNPAUSED:
			SoundManager.play_clip(sound, SoundManager.SOUND_PAUSE)
			show()
			lives_label.text = str(PlayerManager.get_lives())
