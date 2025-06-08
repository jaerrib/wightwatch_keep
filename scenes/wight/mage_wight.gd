class_name MageWight extends EnemyBase

var _attacking: bool = false
var _attack_number: int
var _direction: Vector2 = Vector2.ZERO
var _flip_sprite: bool = false
var _invincible: bool = false
var _life: int = 20
var _speed: float = 10
var _visible: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_timer: Timer = $AttackTimer
@onready var floor_detection: RayCast2D = $FloorDetection
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var sound: AudioStreamPlayer2D = $Sound


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if !_visible:
		return
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		if !_attacking:
			velocity.x = -_speed if animated_sprite_2d.flip_h else _speed
			animated_sprite_2d.play("walk")
		else:
			velocity.x = 0
	move_and_slide()
	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = -floor_detection.position.x
	_flip_sprite = animated_sprite_2d.flip_h


func choose_attack_type() -> void:
	_attack_number = randi_range(1, 2)
	var selection: String = "attack" + str(_attack_number)
	animated_sprite_2d.play(selection)


func generate_spawn_pos() -> Vector2:
	var x_pos: float = randf_range(336, 624)
	return Vector2(x_pos, 10)


func _on_attack_timer_timeout() -> void:
	if !_visible:
		return
	choose_attack_type()
	_attacking = true


func _on_animated_sprite_2d_animation_finished() -> void:
	_attacking = false
	attack_timer.start()
	if _attack_number == 1:
		SoundManager.play_clip(sound, SoundManager.SOUND_BOULDERS)
		summon_rocks()
	else:
		SoundManager.play_clip(sound, SoundManager.SOUND_SUMMON)
		summon_minions()


func summon_rocks() -> void:
	for i in range(0, 5):
		SignalManager.on_create_object.emit(generate_spawn_pos(), Constants.ObjectType.FALLING_ROCK)


func summon_minions() -> void:
	var num: int = randi_range(3, 7)
	for i in range(0, num):
		SignalManager.on_create_enemy.emit(generate_spawn_pos(), Constants.EnemyType.MINION)


func on_hit_box_entered(area: Area2D) -> void:
	go_invincible()
	_life -= 1
	if _life <= 0:
		die()
		SignalManager.on_mage_wight_killed.emit(global_position)


func go_invincible() -> void:
	_invincible = true
	animation_player.play("damaged")
	invincible_timer.start()


func _on_invincible_timer_timeout() -> void:
	_invincible = false
	animation_player.stop()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	_visible = true
	attack_timer.start()
