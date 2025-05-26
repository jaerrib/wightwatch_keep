class_name Ladder extends Node2D

@export var disabled_status: bool = true

@onready var collision_shape_2d: CollisionShape2D = $LadderArea/CollisionShape2D


func _ready() -> void:
	set_disabled_status(disabled_status)


func _on_ladder_area_area_entered(area: Area2D) -> void:
	SignalManager.on_ladder.emit(true)


func _on_ladder_area_area_exited(area: Area2D) -> void:
	SignalManager.on_ladder.emit(false)


func set_disabled_status(status: bool) -> void:
	collision_shape_2d.set_deferred("disabled", status)


func toggle_status() -> void:
	disabled_status = !disabled_status
	set_disabled_status(disabled_status)
