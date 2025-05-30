extends Node

const SOUND_COIN = "coin"
const SOUND_DAMAGE = "sound_damage"
const SOUND_EXIT = "exit"
const SOUND_EXPLOSION = "enemy_hurt_3"
const SOUND_KEY = "key"
const SOUND_MAGIC = "magic"
const SOUND_PAUSE = "pause"
const SOUND_PLAYER_ATTACK = "player_attack"
const SOUND_PLAYER_DEATH = "player_death"

var SOUNDS: Dictionary = {
	SOUND_PLAYER_ATTACK: preload("res://assets/audio/player_attack.wav") ,
	SOUND_EXPLOSION: preload("res://assets/audio/enemy_hurt_3.wav"),
	SOUND_COIN: preload("res://assets/audio/enemy_alert_4.wav"),
	SOUND_KEY: preload("res://assets/audio/pickup_2.wav"),
	SOUND_EXIT: preload("res://assets/audio/pickup_1.wav"),
	SOUND_MAGIC: preload("res://assets/audio/magic.ogg"),
	SOUND_DAMAGE: preload("res://assets/audio/player_hurt.ogg"),
	SOUND_PLAYER_DEATH: preload("res://assets/audio/player_death.ogg"),
	SOUND_PAUSE: preload("res://assets/audio/pause.ogg")
}


func play_clip(player: AudioStreamPlayer2D, clip_key: String) -> void:
	if SOUNDS.has(clip_key) == false:
		return
	player.stream = SOUNDS[clip_key]
	player.play()
