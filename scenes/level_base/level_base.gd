class_name LevelBase extends Node2D

@onready var music: AudioStreamPlayer = $Music
@onready var level_overlay: ColorRect = $CanvasLayer/LevelOverlay


func _ready() -> void:
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_player_died.connect(on_player_died)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("advance"):
		GameManager.load_next_level_scene()
	if Input.is_action_just_pressed("quit"):
		GameManager.load_main_scene()


func on_game_over() -> void:
	for mv in get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP):
		mv.set_process(false)
		mv.set_physics_process(false)


func on_player_died() -> void:
	for mv in get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP):
		mv.set_process(false)
		mv.set_physics_process(false)
