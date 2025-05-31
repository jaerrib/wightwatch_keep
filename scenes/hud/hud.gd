extends Control

var _hearts: Array
var _can_continue: bool = false

@onready var color_rect: ColorRect = $ColorRect
@onready var continue_timer: Timer = $ContinueTimer
@onready var death_timer: Timer = $DeathTimer
@onready var hb_hearts: HBoxContainer = $MC/MC2/HB/HBHearts
@onready var level_label: Label = $MC/MC2/HB/HBLevel/LevelLabel
@onready var lives_label: Label = $ColorRect/VBPlayerDied/HB/LivesLabel
@onready var music: AudioStreamPlayer = $Music
@onready var score_label: Label = $MC/MC2/HB/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var vb_level_complete: VBoxContainer = $ColorRect/VBLevelComplete
@onready var vb_game_over: VBoxContainer = $ColorRect/VBGameOver
@onready var vb_player_died: VBoxContainer = $ColorRect/VBPlayerDied


func _ready() -> void:
	var level: int = GameManager.get_current_level()
	level_label.text = str(level)
	on_score_updated(ScoreManager.get_score())
	_hearts = hb_hearts.get_children()
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_died.connect(on_player_died)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_exit_reached.connect(on_exit_reached)
	SignalManager.on_heart_collected.connect(set_hearts)
	set_hearts()


func _process(_delta: float) -> void:
	if _can_continue and Input.is_action_just_pressed("jump"):
		if vb_game_over.visible:
			GameManager.load_main_scene()
		else:
			if vb_player_died.visible:
				GameManager.reload_current_level_scene()
			else:
				if GameManager.get_current_level() == 26:
					GameManager.load_end_scene()
				else:
					GameManager.load_next_level_scene()


func on_score_updated(score: int) -> void:
	score_label.text = "%05d" % score


func set_hearts() -> void:
	var hearts: int = PlayerManager.get_hearts()
	for life in range(_hearts.size()):
		_hearts[life].visible = life < hearts


func on_player_hit() -> void:
	PlayerManager.reduce_hearts()
	set_hearts()


func show_hud() -> void:
	color_rect.show()
	continue_timer.start()


func on_game_over() -> void:
	stop_level_music()
	music.play()
	show_hud()
	vb_game_over.show()		


func stop_level_music():
	for node in get_tree().get_nodes_in_group("level_music"):
		if node is AudioStreamPlayer and node.playing:
			node.stop()


func on_player_died() -> void:
	SoundManager.play_clip(sound, SoundManager.SOUND_PLAYER_DEATH) 
	death_timer.start()


func on_exit_reached() -> void:
	show_hud()
	vb_level_complete.show()


func _on_continue_timer_timeout() -> void:
	_can_continue = true


func _on_death_timer_timeout() -> void:
	PlayerManager.reduce_lives()
	if PlayerManager.get_lives() <= 0:
		return
	lives_label.text  = str(PlayerManager.get_lives())
	show_hud()
	vb_player_died.show()
