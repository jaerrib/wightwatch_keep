extends LevelBase

const AMBIENCE = "ambience"
const BOSS_MUSIC = "boss_music"
const HEART_SPAWN_POS: Vector2 = Vector2(480, 120)
const SOUNDS: Dictionary = {
	AMBIENCE: preload("res://assets/audio/ambience.ogg"),
	BOSS_MUSIC: preload("res://assets/audio/Boss.ogg"),
}

@onready var heart_spawn_sound: AudioStreamPlayer2D = $HeartSpawnSound
@onready var key: Area2D = $Key
@onready var ladder_1: Ladder = $Ladders/Ladder1
@onready var ladder_2: Ladder = $Ladders/Ladder2
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var camera_trigger: Area2D = $CameraTrigger


func _ready() -> void:
	super._ready()
	level_setup()
	music.stream = SOUNDS[AMBIENCE]
	music.play()
	SignalManager.on_mage_wight_killed.connect(on_mage_wight_killed)
	SignalManager.on_warrior_wight_killed.connect(on_warrior_wight_killed)
	SignalManager.on_heart_spawn.connect(on_heart_spawn)


func level_setup() -> void:
	key.hide()
	key.set_collision_mask_value(2, false)
	ladder_1.set_disabled_status(true)
	ladder_1.set_disabled_status(true)
	ladder_1.hide()
	ladder_2.hide()


func make_hidden_things_visible() -> void:
	key.show()
	key.set_collision_mask_value(2, true)
	ladder_1.toggle_status()
	ladder_2.toggle_status()
	ladder_1.show()	
	ladder_2.show()


func on_mage_wight_killed(position: Vector2) -> void:
	var adjusted_pos: Vector2 = Vector2(position.x, position.y - 8)
	SignalManager.on_create_enemy.emit(adjusted_pos, Constants.EnemyType.WARRIOR_WIGHT)


func on_warrior_wight_killed() -> void:
	make_hidden_things_visible()


func _on_camera_trigger_area_entered(area: Area2D) -> void:
	camera_2d.limit_left = 320
	camera_2d.limit_right = 640
	music.stop()
	music.stream = SOUNDS[BOSS_MUSIC]
	music.play()


func on_heart_spawn() -> void:
	SignalManager.on_create_object.emit(HEART_SPAWN_POS, Constants.ObjectType.HEART)
	SoundManager.play_clip(heart_spawn_sound, SoundManager.SOUND_COIN)
