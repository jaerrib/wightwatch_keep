extends EnemyBase

var _attacking: bool = false
var _throw_direction: Vector2
var _facing: bool = false
var _flip_sprite: bool = false
var _nearby: bool = false
var _shoot_position: Vector2
var _shoot_speed: float = 40
var _speed: float = 10.0
var _waiting: bool = false

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer
@onready var wait_timer: Timer = $WaitTimer


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		if !_attacking and !_waiting:
			velocity.x = -_speed if animated_sprite_2d.flip_h else _speed
			animated_sprite_2d.play("walk")
			check_attack()
		else:
			velocity.x = 0
			if _waiting:
				animated_sprite_2d.play("idle")
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()
	
func check_attack() -> void:
	if _attacking:
		return
	var x_dir = _player_ref.global_position.x - global_position.x
	var y_dir = _player_ref.global_position.y - global_position.y
	_facing = (x_dir > 0 and !animated_sprite_2d.flip_h) or (x_dir < 0 and animated_sprite_2d.flip_h)
	_nearby = (abs(x_dir) < 56) and abs(y_dir) < 24
	if !_attacking and !_waiting and _facing and _nearby:
		attack()


func set_up_throw():
	_shoot_position = Vector2(global_position.x, global_position.y - 5)
	_throw_direction = Vector2(-3, -2) if animated_sprite_2d.flip_h else Vector2(3, -2)


func attack() -> void:
	animated_sprite_2d.play("attack")
	_attacking = true
	attack_timer.start()


func _on_attack_timer_timeout() -> void:
	_attacking = false
	_waiting = true
	wait_timer.start()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
	_flip_sprite = animated_sprite_2d.flip_h


func throw_flask() -> void:
	SignalManager.on_create_projectile.emit(
		_shoot_position,
		_throw_direction,
		_shoot_speed,
		_flip_sprite,
		BaseProjectile.ProjectileType.FLASK)


func _on_wait_timer_timeout() -> void:
	_waiting = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation.contains("attack"):
		set_up_throw()
		throw_flask()
