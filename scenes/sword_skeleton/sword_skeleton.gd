extends EnemyBase

@export var speed: float = 10.0
@export var right_collision_position: Vector2 = Vector2(9,0)
@export var left_collision_position: Vector2 = Vector2(-8,0)

var facing: bool = false
var nearby: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_detection: RayCast2D = $FloorDetection
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sword_collision: CollisionShape2D = $SwordHitBox/CollisionShape2D
@onready var sword_hit_box: Area2D = $SwordHitBox


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = speed if sprite_2d.flip_h else -speed
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()
	check_attack()


func flip_me() -> void:
	sprite_2d.flip_h = !sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
	set_sword_hit_box_position()


func set_sword_hit_box_position() -> void:
	if sprite_2d.flip_h:
		sword_hit_box.position = right_collision_position
	else:
		sword_hit_box.position = left_collision_position


func check_attack() -> void:
	var x_dir = _player_ref.global_position.x - global_position.x
	var y_dir = _player_ref.global_position.y - global_position.y
	facing = (x_dir < 0 and !sprite_2d.flip_h) or (x_dir > 0 and sprite_2d.flip_h)
	nearby = (abs(x_dir) < 32) and abs(y_dir) < 16
	if facing and nearby:
		sword_collision.disabled = false
		animation_player.play("attack")
	else:
		sword_collision.disabled = true
		animation_player.play("walk")
