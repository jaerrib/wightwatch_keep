extends StaticBody2D

@export var flipped: bool = false

var _direction: Vector2 = Vector2.ZERO
var _shoot_position: Vector2
var _speed: float = 50
var _flip_sprite: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite_2d.flip_h = flipped
	if sprite_2d.flip_h:
		_direction = Vector2.RIGHT
	else:
		_direction = Vector2.LEFT
	_flip_sprite = sprite_2d.flip_h
	set_shoot_position()


func _on_shoot_timer_timeout() -> void:
	SignalManager.on_create_object.emit(_shoot_position, Constants.ObjectType.EXPLOSION)
	SignalManager.on_create_projectile.emit(
		_shoot_position,
		_direction,
		_speed,
		_flip_sprite,
		BaseProjectile.ProjectileType.CANNONBALL
		)
		
func set_shoot_position():
	if sprite_2d.flip_h:
		_shoot_position.x = global_position.x + 12
	else:
		_shoot_position.x = global_position.x - 12
	_shoot_position.y = global_position.y - 3
