extends EnemyBase

@export var speed: float = 40.0

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
			animated_sprite_2d.play("move")
			velocity.x = speed if animated_sprite_2d.flip_h else -speed
		else:
			animated_sprite_2d.play("idle")
			velocity.x = 0
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()


func check_player_proximity() -> void:
	var x_dir = _player_ref.global_position.x - global_position.x
	var y_dir = _player_ref.global_position.y - global_position.y
	_nearby = (abs(x_dir) < 64) and abs(y_dir) < 16


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
