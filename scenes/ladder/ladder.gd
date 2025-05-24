class_name Ladder extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $LadderArea/CollisionShape2D


func _on_ladder_area_area_entered(area: Area2D) -> void:
	SignalManager.on_ladder.emit(true)


func _on_ladder_area_area_exited(area: Area2D) -> void:
	SignalManager.on_ladder.emit(false)


func activate() -> void:
	collision_shape_2d.disabled = false


func deactivate() -> void:
	collision_shape_2d.disabled = true
