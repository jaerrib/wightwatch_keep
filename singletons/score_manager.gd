extends Node

var _score: int = 0

func _ready() -> void:
	SignalManager.on_coin_collected.connect(update_score)
	SignalManager.on_enemy_hit.connect(update_score)


func update_score(p: int) -> void:
	_score += p
	SignalManager.on_score_updated.emit(_score)
	
	
func reset_score():
	_score = 0


func get_score() -> int:
	return _score


func compare_scores(a, b):
	return b.score < a.score
