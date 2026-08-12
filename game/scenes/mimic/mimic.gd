extends EnemyBase

const GRAVITY: float = 300.0
const JUMP_VELOCITY: float = -50.0

@export var speed: float = 40.0

var _facing: bool = false
var _nearby: bool = false

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	check_player_proximity()
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		if _nearby:
			animated_sprite_2d.play("attack")
			if !_facing:
				flip_me()
			velocity.x = speed if animated_sprite_2d.flip_h else -speed
			velocity.y = JUMP_VELOCITY
		else:
			animated_sprite_2d.play("default")
			velocity.x = 0
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()


func check_player_proximity() -> void:
	var x_dir = _player_ref.global_position.x - global_position.x
	var y_dir = _player_ref.global_position.y - global_position.y
	_facing = (x_dir < 0 and !animated_sprite_2d.flip_h) or (x_dir > 0 and animated_sprite_2d.flip_h)
	_nearby = (abs(x_dir) < 32) and abs(y_dir) < 16


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
