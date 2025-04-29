extends EnemyBase

var _nearby: bool = false
var _spores: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var burst_timer: Timer = $BurstTimer
@onready var hit_box: Area2D = $HitBox
@onready var spore_timer: Timer = $SporeTimer


func _process(delta: float) -> void:
	check_player_proximity()
	determine_activity()


func determine_activity() -> void:
	if _spores:
		return
	else:
		if _nearby:
			animated_sprite_2d.play("active")
			if burst_timer.is_stopped():
				burst_timer.start()
		else:
			animated_sprite_2d.play("idle")
			if !burst_timer.is_stopped():
				burst_timer.stop()


func check_player_proximity() -> void:
	var x_dir = _player_ref.global_position.x - global_position.x
	var y_dir = _player_ref.global_position.y - global_position.y
	_nearby = (abs(x_dir) < 32) and abs(y_dir) < 16


func _on_burst_timer_timeout() -> void:
	animated_sprite_2d.play("burst")
	_spores = true
	hit_box.set_collision_mask_value(3, false)
	spore_timer.start()


func _on_spore_timer_timeout() -> void:
	removal_timer.start()
