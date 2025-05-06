extends Node2D

@export var color_overlay: String = "00000080"

@onready var music: AudioStreamPlayer = $Music
@onready var level_overlay: ColorRect = $CanvasLayer/LevelOverlay


func _ready() -> void:
	level_overlay.color = Color(color_overlay)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("advance"):
		GameManager.load_next_level_scene()
	if Input.is_action_just_pressed("quit"):
		GameManager.load_main_scene()


func on_game_over() -> void:
	for mv in get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP):
		mv.set_process(false)
		mv.set_physics_process(false)
