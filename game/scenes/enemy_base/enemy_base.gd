class_name EnemyBase extends CharacterBody2D

const OFF_SCREEN_KILL_ME: float = 400.0

@export var points: int = 1

var _player_ref: Player
var _gravity: float = 800.0
var _dying: bool = false

@onready var hit_box: Area2D = $HitBox
@onready var removal_timer: Timer = $RemovalTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)


func _physics_process(delta: float) -> void:
	fallen_off()


func fallen_off() -> void:
	if global_position.y > OFF_SCREEN_KILL_ME:
		queue_free() 


func die() -> void:
	if _dying:
		return
	_dying = true
	set_physics_process(false)
	hide()
	SignalManager.on_enemy_hit.emit(points)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.EXPLOSION)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.COIN)
	removal_timer.start()


func _on_hit_box_area_entered(area: Area2D) -> void:
	hit_box.set_deferred("monitorable", false)
	collision_shape_2d.set_deferred("disabled", true)
	die()


func _on_removal_timer_timeout() -> void:
	queue_free()
