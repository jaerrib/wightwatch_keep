class_name FallingRock extends RigidBody2D

const FALLEN_OFF: float = 325

var _sprite_selection: int = randi_range(0, 2)

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite_2d.frame = _sprite_selection


func _physics_process(delta: float) -> void:
	if global_position.y > FALLEN_OFF:
		set_physics_process(false)
		queue_free()
