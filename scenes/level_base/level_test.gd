extends LevelBase

@onready var ladder: Ladder = $Ladders/Ladder

func _process(delta: float) -> void:
	super._process(delta)
	if Input.is_action_just_pressed("spawn"):
		ladder.toggle_status()


func generate_spawn_pos() -> Vector2:
	var x_pos: float = randf_range(16, 304)
	return Vector2(x_pos, 10)
