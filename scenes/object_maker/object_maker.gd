extends Node2D

const ADD_OBJECT: String = "add_object"

const OBJECT_SCENES: Dictionary = {
	Constants.ObjectType.COIN: preload("res://scenes/coin/coin.tscn"),
	Constants.ObjectType.EXPLOSION: preload("res://scenes/explosion/explosion.tscn")
}

const PROJECTILE_SCENE: Dictionary = {
	Constants.ProjectileType.CANNONBALL: preload("res://scenes/cannon_ball/cannonball.tscn"),
}

func _ready() -> void:
	SignalManager.on_create_object.connect(on_create_object)
	SignalManager.on_create_projectile.connect(on_create_projectile)


func on_create_object(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var n_obj = OBJECT_SCENES[ob_type].instantiate()
	n_obj.position = pos
	call_deferred("add_child", n_obj)


func on_create_projectile(
	start_pos: Vector2,
	direction: Vector2,
	speed: float,
	projectile_type: BaseProjectile.ProjectileType ) -> void:
	if !PROJECTILE_SCENE.has(projectile_type):
		print("NOPE")
		return
	var scene = PROJECTILE_SCENE[projectile_type].instantiate()
	scene.position = start_pos
	scene.setup(direction, speed)
	call_deferred(ADD_OBJECT, scene, start_pos)
	print("SCENE", scene)


func add_object(obj: Node, global_position: Vector2) -> void:
	add_child(obj)
	obj.global_position = global_position
