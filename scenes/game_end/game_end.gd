extends Control

@onready var bad_ending: RichTextLabel = $MarginContainer/Pages/BadEnding
@onready var good_ending: RichTextLabel = $MarginContainer/Pages/GoodEnding
@onready var neutral_ending: RichTextLabel = $MarginContainer/Pages/NeutralEnding


func _ready() -> void:
	var lives_remaining = PlayerManager.get_lives()
	if lives_remaining >= 8:
		good_ending.show()
	else:
		if lives_remaining >=4:
			neutral_ending.show
		else:
			bad_ending.show()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		GameManager.load_main_scene()


func _on_timer_timeout() -> void:
	GameManager.load_main_scene()
