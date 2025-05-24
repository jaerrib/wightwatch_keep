extends EnemyBase

const POSITION_TOGGLE: float = 200.0

@export var speed: float = 40.0

var _falling: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var floor_detection: RayCast2D = $FloorDetection

func _ready() -> void:
	var flipped: bool = [true, false].pick_random()
	animated_sprite_2d.flip_h = flipped


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	check_falling_status()
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = speed if animated_sprite_2d.flip_h else -speed
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()


func check_falling_status():
	if global_position.y > POSITION_TOGGLE:
		_falling = false
		collision_shape_2d.disabled = false


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
