extends EnemyBase

@export var speed: float = 5.0

var _moving: bool = false

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_timer: Timer = $MoveTimer
@onready var pause_timer: Timer = $PauseTimer


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
	else:
		velocity.x = 0
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
