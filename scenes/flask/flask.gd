extends RigidBody2D

@export var sprite: Sprite2D

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var floor_detection_2: RayCast2D = $FloorDetection2
@onready var floor_detection_3: RayCast2D = $FloorDetection3
@onready var floor_detection_4: RayCast2D = $FloorDetection4


func setup(direction: Vector2, speed: float, flip_sprite: bool) -> void:
	linear_velocity = direction * speed
	sprite.flip_h = flip_sprite


func _physics_process(delta: float) -> void:
	if (
		floor_detection.is_colliding() or
		floor_detection_2.is_colliding() or
		floor_detection_3.is_colliding() or
		floor_detection_4.is_colliding()
		):
		queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
