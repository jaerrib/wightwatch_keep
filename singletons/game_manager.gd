extends Node

const MAIN = preload("res://scenes/main/main.tscn")
const TOTAL_LEVELS: int = 26

var _level_scenes: Dictionary = {}
var _current_level: int = 0


func _ready() -> void:
	for ln in range(1, TOTAL_LEVELS + 1):
		_level_scenes[ln] = load("res://scenes/level_base/level_%d.tscn" % ln)


func load_main_scene() -> void:
	_current_level = 0
	get_tree().change_scene_to_packed(MAIN)


func load_next_level_scene() -> void:
	set_next_level()
	get_tree().change_scene_to_packed(_level_scenes[_current_level])


func reload_current_level_scene() -> void:
	get_tree().change_scene_to_packed(_level_scenes[_current_level])


func set_next_level() -> void:
	_current_level += 1
	if _current_level > TOTAL_LEVELS:
		_current_level = 1


func get_current_level() -> int:
	return _current_level
