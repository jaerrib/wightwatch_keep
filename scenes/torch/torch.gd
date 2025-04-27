extends Area2D

func _on_area_entered(area: Area2D) -> void:
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.COIN)
	queue_free()
