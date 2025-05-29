extends EnemyBase

var _attacking: bool = false
var _direction: Vector2 = Vector2.ZERO
var facing: bool = false
var _flip_sprite: bool = false
var nearby: bool = false
var _shoot_position: Vector2
var _shoot_speed: float = 50
var _speed: float = 20

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_detection: RayCast2D = $FloorDetection
@onready var sound: AudioStreamPlayer2D = $Sound


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		if !_attacking:
			velocity.x = -_speed if animated_sprite_2d.flip_h else _speed
			animated_sprite_2d.play("walk")
		else:
			velocity.x = 0
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()
	check_attack()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
	_flip_sprite = animated_sprite_2d.flip_h


func shoot_magic() -> void:
	SignalManager.on_create_projectile.emit(
		_shoot_position,
		_direction,
		_shoot_speed,
		_flip_sprite,
		BaseProjectile.ProjectileType.MAGIC
		)


func check_attack() -> void:
	if _attacking:
		return
	var x_dir = _player_ref.global_position.x - global_position.x
	var y_dir = _player_ref.global_position.y - global_position.y
	facing = (x_dir > 0 and !animated_sprite_2d.flip_h) or (x_dir < 0 and animated_sprite_2d.flip_h)
	nearby = (abs(x_dir) < 56) and abs(y_dir) < 16
	if !_attacking and facing and nearby:
		attack()


func set_shoot_position():
	if animated_sprite_2d.flip_h:
		_shoot_position.x = global_position.x - 8
		_direction = Vector2.LEFT
	else:
		_shoot_position.x = global_position.x + 8
		_direction = Vector2.RIGHT
	_shoot_position.y = global_position.y


func attack() -> void:
	animated_sprite_2d.play("attack")
	set_shoot_position()
	shoot_magic()
	SoundManager.play_clip(sound, SoundManager.SOUND_MAGIC)
	_attacking = true
	attack_timer.start()


func _on_attack_timer_timeout() -> void:
	_attacking = false
