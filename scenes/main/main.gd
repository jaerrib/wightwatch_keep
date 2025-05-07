extends Control


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		GameManager.load_game_container_scene()
