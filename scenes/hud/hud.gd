extends Control

var _hearts: Array
var _can_continue: bool = false

@onready var color_rect: ColorRect = $ColorRect
@onready var continue_timer: Timer = $ContinueTimer
@onready var hb_hearts: HBoxContainer = $MC/MC2/HB/HBHearts
@onready var level_label: Label = $MC/MC2/HB/HBLevel/LevelLabel
@onready var score_label: Label = $MC/MC2/HB/ScoreLabel
@onready var sound: AudioStreamPlayer = $Sound
@onready var vb_level_complete: VBoxContainer = $ColorRect/VBLevelComplete
@onready var vb_game_over: VBoxContainer = $ColorRect/VBGameOver



func _ready() -> void:
	var level: int = GameManager.get_current_level()
	level_label.text = str(level)
	on_score_updated(ScoreManager.get_score())
	_hearts = hb_hearts.get_children()
	#SignalManager.on_player_hit.connect(on_player_hit)
	#SignalManager.on_level_started.connect(on_player_hit)
	#SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_exit_reached.connect(on_exit_reached)
	#SignalManager.on_level_complete.connect(on_level_complete)


func _process(_delta: float) -> void:
	if _can_continue and Input.is_action_just_pressed("jump"):
		if vb_game_over.visible:
			GameManager.load_main_scene()
		else:
			GameManager.load_next_level_scene()


func on_score_updated(score: int) -> void:
	score_label.text = "%05d" % score


func on_player_hit(lives: int) -> void:
	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life


func show_hud() -> void:
	color_rect.show()
	continue_timer.start()


func on_game_over() -> void:
	#sound.play()
	show_hud()
	vb_game_over.show()


func on_exit_reached() -> void:
	show_hud()
	vb_level_complete.show()


func _on_continue_timer_timeout() -> void:
	_can_continue = true
