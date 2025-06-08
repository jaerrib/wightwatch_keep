extends Node

const SOUND_BOSS_HURT = "boss_hurt"
const SOUND_COIN = "coin"
const SOUND_DAMAGE = "sound_damage"
const SOUND_EXIT = "exit"
const SOUND_EXPLOSION = "enemy_hurt_3"
const SOUND_KEY = "key"
const SOUND_SUMMON = "summon"
const SOUND_BOULDERS = "boulders"
const SOUND_MAGIC = "magic"
const SOUND_PAUSE = "pause"
const SOUND_PLAYER_ATTACK = "player_attack"
const SOUND_PLAYER_DEATH = "player_death"
const SOUND_ROAR = "roar"
const SOUND_WARRIOR_SWING = "warrior_swing"

var SOUNDS: Dictionary = {
	SOUND_PLAYER_ATTACK: preload("res://assets/audio/player_attack.ogg") ,
	SOUND_EXPLOSION: preload("res://assets/audio/enemy_hurt_3.ogg"),
	SOUND_COIN: preload("res://assets/audio/enemy_alert_4.ogg"),
	SOUND_KEY: preload("res://assets/audio/pickup_2.ogg"),
	SOUND_EXIT: preload("res://assets/audio/pickup_1.ogg"),
	SOUND_MAGIC: preload("res://assets/audio/magic.ogg"),
	SOUND_DAMAGE: preload("res://assets/audio/player_hurt.ogg"),
	SOUND_PLAYER_DEATH: preload("res://assets/audio/player_death.ogg"),
	SOUND_PAUSE: preload("res://assets/audio/pause.ogg"),
	SOUND_SUMMON: preload("res://assets/audio/summon.ogg"),
	SOUND_BOULDERS: preload("res://assets/audio/boulders.ogg"),
	SOUND_WARRIOR_SWING: preload("res://assets/audio/warrior_swing.ogg"),
	SOUND_ROAR: preload("res://assets/audio/roar.ogg"),
	SOUND_BOSS_HURT: preload("res://assets/audio/boss_hurt.ogg")
}


func play_clip(player: AudioStreamPlayer2D, clip_key: String) -> void:
	if SOUNDS.has(clip_key) == false:
		return
	player.stream = SOUNDS[clip_key]
	player.play()
