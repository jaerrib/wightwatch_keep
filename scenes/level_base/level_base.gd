extends Node2D

const COLOR_OVERLAY: Array = [
	"#4B008280",
	"#556B2F80",
	"#8B000080",
	"#4682B480",
	"#D2B55880",
	]

var _color: String


@onready var music: AudioStreamPlayer = $Music
@onready var color_overlay: ColorRect = $CanvasLayer/ColorOverlay


func _ready() -> void:
	#SignalManager.on_game_over.connect(on_game_over)
	#SignalManager.on_level_complete.connect(on_level_complete)
	SignalManager.on_level_start.connect(on_level_start)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("advance"):
		GameManager.load_next_level_scene()
	if Input.is_action_just_pressed("quit"):
		GameManager.load_main_scene()


func on_game_over() -> void:
	for mv in get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP):
		mv.set_process(false)
		mv.set_physics_process(false)


func on_level_start(level: int) -> void:
	if level > 20:
		_color = COLOR_OVERLAY[4]
	else:
		if level > 15:
			_color = COLOR_OVERLAY[3]
		else:
			if level > 10:
				_color = COLOR_OVERLAY[2]
			else:
				if level > 5:
					_color = COLOR_OVERLAY[1]
				else:
					_color = COLOR_OVERLAY[0]
		color_overlay.color = _color
