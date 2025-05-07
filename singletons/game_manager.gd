extends Node

const MAIN = preload("res://scenes/main/main.tscn")
const GAME_CONTAINER = preload("res://scenes/game_container/game_container.tscn")
const TOTAL_LEVELS: int = 6

var _level_scenes: Dictionary = {}
var _current_level: int = 0


func _ready() -> void:
	for ln in range(1, TOTAL_LEVELS + 1):
		_level_scenes[ln] = load("res://scenes/level_base/level_%d.tscn" % ln)

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)


func load_game_container_scene() -> void:
	_current_level = 1
	get_tree().change_scene_to_packed(GAME_CONTAINER)


func load_next_level_scene() -> void:
	set_next_level()
	var game_container = get_tree().root.get_node("GameContainer")
	var level_container = game_container.get_node("LevelContainer")
	if level_container.get_child_count() > 0:
		level_container.get_child(0).queue_free()
	var new_level = _level_scenes[_current_level].instantiate()
	get_tree().change_scene_to_packed(_level_scenes[_current_level])


func set_next_level() -> void:
	_current_level += 1
	if _current_level > TOTAL_LEVELS:
		_current_level = 1
