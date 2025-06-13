extends Node

const SCORES_PATH = "user://wightwatch_keep.dat"

var _score: int = 0
var _high_score: int = 0


func _ready() -> void:
	SignalManager.on_coin_collected.connect(update_score)
	SignalManager.on_enemy_hit.connect(update_score)
	SignalManager.on_game_over.connect(on_game_over)
	load_high_score()


func update_score(p: int) -> void:
	_score += p
	if _high_score < _score:
		_high_score = _score
	SignalManager.on_score_updated.emit(_score)


func reset_score():
	_score = 0


func get_score() -> int:
	return _score


func compare_scores(a, b):
	return b.score < a.score


func get_high_score() -> int:
	return _high_score


func load_high_score() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			_high_score = file.get_as_text().to_int()
			print("Loaded high score")
		else:
			print("Nothing in file")
		file.close()
	else:
		print("Failed to load file")


func on_game_over() -> void:
	save_high_score_to_file()


func save_high_score_to_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	if file:
		file.store_string(str(_high_score))
		file.close
