extends EnemyBase

@export var speed: float = 40.0

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = speed if animated_sprite_2d.flip_h else -speed
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
