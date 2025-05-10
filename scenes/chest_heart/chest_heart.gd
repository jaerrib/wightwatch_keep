extends Chest

func _on_hit_box_area_entered(area: Area2D) -> void:
	super._on_hit_box_area_entered(area)
	if !_can_collect:
		return
	animated_sprite_2d.play("open")
	var spawn_pos: Vector2
	SignalManager.on_create_object.emit(spawn_pos, Constants.ObjectType.COIN)
	_can_collect = false
