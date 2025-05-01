class_name BaseProjectile extends Area2D

enum ProjectileType { CANNONBALL, FLASK, MAGIC }

@export var damage: int = 1

var _direction: Vector2 = Vector2.ZERO
var _speed: float = 200.0
var _flip_sprite: bool = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.flip_h = _flip_sprite


func _process(delta: float) -> void:
	position += _direction * _speed * delta


func setup(direction: Vector2, speed: float, flip_sprite: bool) -> void:
	_direction = direction.normalized()
	_speed = speed
	_flip_sprite = flip_sprite


func deactivate () -> void:
	collision_shape_2d.call_deferred("set_disabled", true)


func get_damage() -> int:
	return damage


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	set_process(false)
	queue_free()
