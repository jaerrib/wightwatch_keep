extends Node

const MAX_HEARTS: int = 5
const STARTING_LIVES: int = 3

var _hearts: int
var _lives: int


func set_initial_stats() -> void:
	_hearts = MAX_HEARTS
	_lives = STARTING_LIVES


func get_lives() -> int:
	return _lives


func get_hearts() -> int:
	return _hearts


func reduce_hearts() -> void:
	_hearts -= 1
	if _hearts < 1:
		SignalManager.on_player_died.emit()


func increase_hearts(amt: int) -> void:
	_hearts = 5 if _hearts + amt > 5 else _hearts + amt


func reduce_lives() -> void:
	_lives -= 1
	_hearts = MAX_HEARTS
	if _lives <= 0:
		SignalManager.on_game_over.emit()


func gain_extra_life() -> void:
	_lives += 1


func player_is_at_full_hearts() -> bool:
	return _hearts == MAX_HEARTS
