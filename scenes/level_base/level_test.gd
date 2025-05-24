extends LevelBase

func _process(delta: float) -> void:
	super._process(delta)
	if Input.is_action_just_pressed("spawn"):
		for i in range(0, 5):
			SignalManager.on_create_falling_rock.emit(generate_spawn_pos())


func generate_spawn_pos() -> Vector2:
	var x_pos: float = randf_range(16, 304)
	return Vector2(x_pos, 10)
