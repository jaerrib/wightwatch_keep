extends AnimatableBody2D

@export var points: int = 1

var _dying: bool = false
var _end: Vector2
var _start: Vector2
var _time_to_move: float = 0.0
var _tween: Tween

@export var destination: Marker2D
@onready var removal_timer: Timer = $RemovalTimer
@export var speed: float = 20.0


func _ready() -> void:
	_start = global_position
	_end = destination.global_position
	var distance: float = _start.distance_to(_end)
	_time_to_move = distance / speed
	set_moving()


func _exit_tree() -> void:
	if _tween:
		_tween.kill()


func set_moving() -> void:
	_tween = get_tree().create_tween()
	_tween.set_loops()
	_tween.tween_property(self, "global_position", _end, _time_to_move)
	_tween.tween_property(self, "global_position", _start, _time_to_move)


func die() -> void:
	#SoundManager.play_clip(sound, SoundManager.SOUND_ENEMY_HURT)
	if _dying:
		return
	_dying = true
	set_physics_process(false)
	hide()
	# pick up, sound, and explosion
	#SignalManager.on_enemy_hit.emit(points)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.EXPLOSION)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.COIN)
	removal_timer.start()


func _on_removal_timer_timeout() -> void:
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	die()
