extends Control

@onready var bad_ending: RichTextLabel = $MarginContainer/Endings/BadEnding
@onready var credits: RichTextLabel = $MarginContainer/Credits
@onready var endings: Control = $MarginContainer/Endings
@onready var good_ending: RichTextLabel = $MarginContainer/Endings/GoodEnding
@onready var music: AudioStreamPlayer = $Music
@onready var neutral_ending: RichTextLabel = $MarginContainer/Endings/NeutralEnding


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
		check_visible_text()

func show_credits() -> void:
	endings.hide()
	credits.show()


func check_visible_text() -> void:
	if credits.visible:
		music.volume_linear
		GameManager.load_main_scene()
	else:
		show_credits()


func _on_timer_timeout() -> void:
	check_visible_text()
