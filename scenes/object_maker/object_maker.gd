extends Node2D

const OBJECT_SCENES: Dictionary = {
	Constants.ObjectType.COIN: preload("res://scenes/coin/coin.tscn"),
	Constants.ObjectType.EXPLOSION: preload("res://scenes/explosion/explosion.tscn")
}


func _ready() -> void:
	SignalManager.on_create_object.connect(on_create_object)


func on_create_object(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var n_obj = OBJECT_SCENES[ob_type].instantiate()
	n_obj.position = pos
	call_deferred("add_child", n_obj)
