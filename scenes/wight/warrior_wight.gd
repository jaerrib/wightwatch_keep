extends EnemyBase

@export var speed: float = 10.0

var _invincible: bool = false
var _life: int = 10
var _nearby: bool = false
var _player_pos: Vector2

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_detection: RayCast2D = $FloorDetection
@onready var invincible_animation: AnimationPlayer = $InvincibleAnimation
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sword_collision: CollisionShape2D = $SwordHitBox/CollisionShape2D
@onready var sword_hit_box: Area2D = $SwordHitBox
@onready var turn_timer: Timer = $TurnTimer


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
	set_sword_hit_box_position()
	check_attack()


func flip_me() -> void:
	sprite_2d.flip_h = !sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
	set_sword_hit_box_position()

func set_sword_hit_box_position() -> void:
	if sprite_2d.flip_h:
		sword_hit_box.position.x = abs(sword_hit_box.position.x)
	else:
		sword_hit_box.position.x = -abs(sword_hit_box.position.x)


func check_attack() -> void:
	get_player_position()
	if is_facing() and is_nearby():
		sword_collision.set_deferred("disabled", false)
		animation_player.play("attack")
	else:
		sword_collision.set_deferred("disabled", true)
		animation_player.play("walk")


func get_player_position() -> void:
	_player_pos.x = _player_ref.global_position.x - global_position.x
	_player_pos.y = _player_ref.global_position.y - global_position.y


func is_facing() -> bool:
	return (_player_pos.x < 0 and !sprite_2d.flip_h) or (_player_pos.x > 0 and sprite_2d.flip_h)
	

func is_nearby() -> bool:
	return (abs(_player_pos.x) < 96) and abs(_player_pos.y) < 48


func on_hit_box_entered(area: Area2D) -> void:
	turn_timer.start()
	go_invincible()
	_life -= 1
	if _life <= 0:
		SignalManager.on_warrior_wight_killed.emit()
		die()


func go_invincible() -> void:
	_invincible = true
	invincible_animation.play("damaged")
	invincible_timer.start()



func _on_invincible_timer_timeout() -> void:
	_invincible = false
	invincible_animation.stop()


func _on_turn_timer_timeout() -> void:
	get_player_position()
	if !is_facing():
		flip_me()
