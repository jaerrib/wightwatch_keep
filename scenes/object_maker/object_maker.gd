extends Node2D

const ADD_OBJECT: String = "add_object"

const OBJECT_SCENES: Dictionary = {
	Constants.ObjectType.COIN: preload("res://scenes/coin/coin.tscn"),
	Constants.ObjectType.EXPLOSION: preload("res://scenes/explosion/explosion.tscn"),
	Constants.ObjectType.HEART: preload("res://scenes/heart/heart.tscn"),
	Constants.ObjectType.HEART_LARGE: preload("res://scenes/heart_large/heart_large.tscn"),
	Constants.ObjectType.FALLING_ROCK: preload("res://scenes/falling_rock/falling_rock.tscn")
}


const ENEMY_SCENE: Dictionary = {
	Constants.EnemyType.SLIME: preload("res://scenes/slime/slime.tscn"),
	Constants.EnemyType.MINION: preload("res://scenes/minion/minion.tscn"),
	Constants.EnemyType.WARRIOR_WIGHT: preload("res://scenes/wight/warrior_wight.tscn")
}

const PROJECTILE_SCENE: Dictionary = {
	Constants.ProjectileType.CANNONBALL: preload("res://scenes/cannon_ball/cannonball.tscn"),
	Constants.ProjectileType.MAGIC: preload("res://scenes/magic/magic.tscn"),
	Constants.ProjectileType.FLASK: preload("res://scenes/flask/flask.tscn"),
}


func _ready() -> void:
	SignalManager.on_create_object.connect(on_create_object)
	SignalManager.on_create_projectile.connect(on_create_projectile)
	SignalManager.on_create_enemy.connect(on_create_enemy)
	SignalManager.on_create_falling_rock.connect(on_create_falling_rock)


func on_create_object(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var n_obj = OBJECT_SCENES[ob_type].instantiate()
	n_obj.position = pos
	call_deferred("add_child", n_obj)


func on_create_falling_rock(position: Vector2):
	var scene = OBJECT_SCENES[Constants.ObjectType.FALLING_ROCK].instantiate()
	scene.position = position
	call_deferred("add_child", scene)


func on_create_projectile(
	start_pos: Vector2,
	direction: Vector2,
	speed: float,
	flip_sprite: bool,
	projectile_type: BaseProjectile.ProjectileType ) -> void:
	if !PROJECTILE_SCENE.has(projectile_type):
		return
	var scene = PROJECTILE_SCENE[projectile_type].instantiate()
	scene.position = start_pos
	scene.setup(direction, speed, flip_sprite)
	call_deferred(ADD_OBJECT, scene, start_pos)


func on_create_enemy(position: Vector2, enemy_type: Constants.EnemyType):
	var scene = ENEMY_SCENE[enemy_type].instantiate()
	scene.position = position
	call_deferred("add_child", scene)


func add_object(obj: Node, global_position: Vector2) -> void:
	add_child(obj)
	obj.global_position = global_position
