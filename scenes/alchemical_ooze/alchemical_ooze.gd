extends EnemyBase

const SPLIT_DISTANCE: float = 8.0

@export var speed: float = 5.0

var _moving: bool = false

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_timer: Timer = $MoveTimer
@onready var pause_timer: Timer = $PauseTimer
@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	super._ready()
	move_timer.start()
	_moving = true


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity.y += _gravity * delta
	elif _moving:
		velocity.x = speed if animated_sprite_2d.flip_h else -speed
		animated_sprite_2d.play("move")
	else:
		velocity.x = 0
		animated_sprite_2d.play("idle")
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x


func _on_move_timer_timeout() -> void:
	_moving = false
	pause_timer.start()


func _on_pause_timer_timeout() -> void:
	_moving = true
	move_timer.start()


func die() -> void:
	#SoundManager.play_clip(sound, SoundManager.SOUND_ENEMY_HURT)
	if _dying:
		return
	_dying = true
	set_physics_process(false)
	hide()
	# pick up, sound, and explosion
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.EXPLOSION)
	split_in_two()
	removal_timer.start()

func split_in_two() -> void:
	var slime1_position: Vector2 = Vector2(global_position.x + SPLIT_DISTANCE, global_position.y)
	SignalManager.on_create_enemy.emit(slime1_position, Constants.EnemyType.SLIME)
	var slime2_position: Vector2 = Vector2(global_position.x - SPLIT_DISTANCE, global_position.y)
	SignalManager.on_create_enemy.emit(slime2_position, Constants.EnemyType.SLIME)
