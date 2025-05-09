extends Control


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		PlayerManager.set_initial_stats()
		GameManager.load_next_level_scene()
