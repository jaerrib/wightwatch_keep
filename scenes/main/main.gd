extends Control

const INTRO = "intro"

var SOUNDS: Dictionary = {
	INTRO: preload("res://assets/audio/Intro.ogg")
}

var _intro_playing: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var music: AudioStreamPlayer = $Music
@onready var pulse_delay: Timer = $PulseDelay


func _process(_delta: float) -> void:
	if !music.has_stream_playback():
		start_game()
	if Input.is_action_just_pressed("jump") and !_intro_playing:
		music.stop()
		music.stream = SOUNDS[INTRO]
		_intro_playing = true
		music.play()
		pulse_delay.start()
		
		
func start_game() -> void:
	PlayerManager.set_initial_stats()
	GameManager.load_next_level_scene()


func _on_pulse_delay_timeout() -> void:
	animation_player.play("pulse")
