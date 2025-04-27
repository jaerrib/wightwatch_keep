class_name Ladder extends Node2D


func _on_ladder_area_area_entered(area: Area2D) -> void:
	SignalManager.on_ladder.emit(true)


func _on_ladder_area_area_exited(area: Area2D) -> void:
	SignalManager.on_ladder.emit(false)
