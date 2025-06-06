extends EnemyBase

const FLY_SPEED: Vector2 = Vector2(10, 10)

var _fly_direction: Vector2 = Vector2.ZERO

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var direction_timer: Timer = $DirectionTimer


func _ready() -> void:
	super._ready()
	direction_timer.start()
	fly_to_player()


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = _fly_direction
	move_and_slide()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


func fly_to_player() -> void:
	var x_dir = sign(_player_ref.global_position.x - global_position.x)
	var y_dir = sign(_player_ref.global_position.y - global_position.y)
	if x_dir > 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
	_fly_direction = Vector2(x_dir, y_dir) * FLY_SPEED


func _on_direction_timer_timeout() -> void:
	fly_to_player()
