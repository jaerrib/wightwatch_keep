extends EnemyBase

@export var speed: float = 30.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.x = speed if animated_sprite_2d.flip_h else -speed
	move_and_slide()
	if is_on_wall():
		flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
