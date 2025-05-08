extends Control

@onready var hb_hearts_2: HBoxContainer = $MC/MC2/HB/HBHearts2
@onready var level_label: Label = $MC/MC2/HB/HB2/LevelLabel
@onready var score_label: Label = $MC/MC2/HB/ScoreLabel

func _ready() -> void:
	var level: int = GameManager.get_current_level()
	level_label.text = str(level)
