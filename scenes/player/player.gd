class_name Player extends CharacterBody2D

enum PlayerState { IDLE, RUN, JUMP, FALL, ON_LADDER, HURT }

const ACCELERATION: float = 350.0
const CLIMB_SPEED: float = 300.0
const FALLEN_OFF: float = 325.0
const GRAVITY: float = 690.0
const HURT_JUMP_VELOCITY: float = -130.0
const JUMP_VELOCITY: float = -175.0
const KNOCKBACK: float = -50.0
const MAX_FALL: float = 400.0
const RUN_SPEED: float = 100.0


@export var right_collision_position: Vector2 = Vector2(9,0)
@export var left_collision_position: Vector2 = Vector2(-9,0)

var _invincible: bool = false
var _on_ladder: bool = false
var _state: PlayerState = PlayerState.IDLE


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $SwordHitBox/CollisionShape2D
@onready var death_sprite: AnimatedSprite2D = $DeathSprite
@onready var hit_box: Area2D = $HitBox
@onready var hurt_timer: Timer = $HurtTimer
@onready var invincible_player: AnimationPlayer = $InvinciblePlayer
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sword_hit_box: Area2D = $SwordHitBox

func _ready() -> void:
	SignalManager.on_ladder.connect(on_ladder)
	SignalManager.on_player_died.connect(on_player_died)


func _physics_process(delta: float) -> void:
	fallen_off()
	if not is_on_floor() and !_on_ladder:
		velocity.y += GRAVITY * delta
	get_input(delta)
	set_sword_hit_box_position()
	calculate_state()
	move_and_slide()


func set_sword_hit_box_position() -> void:
	if sprite_2d.flip_h:
		sword_hit_box.position = left_collision_position
	else:
		sword_hit_box.position = right_collision_position


func fallen_off() -> void:
	if global_position.y < FALLEN_OFF:
		return
	set_physics_process(false)
	queue_free()
	SignalManager.on_player_died.emit()


func get_input(delta) -> void:
	if _state == PlayerState.HURT:
		return
	if Input.is_action_just_pressed("attack"):
		attack()
	if _on_ladder:
		check_ladder_input(delta)
	check_directional_input(delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func check_directional_input(delta) -> void:
	var input_x: int = 0
	if Input.is_action_pressed("left"):
		input_x -= 1
		sprite_2d.flip_h = true
	elif Input.is_action_pressed("right"):
		input_x += 1
		sprite_2d.flip_h = false
	if input_x != 0:
		velocity.x += input_x * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -RUN_SPEED, RUN_SPEED)
	else:
		velocity.x = 0


func check_ladder_input(delta) -> void:
	if Input.is_action_pressed("up"):
		velocity.y = -CLIMB_SPEED * delta * 10
	elif Input.is_action_pressed("down"):
		velocity.y = CLIMB_SPEED * delta * 10
	else:
		velocity.y = 0


func attack() -> void:
	SoundManager.play_clip(sound, SoundManager.SOUND_PLAYER_ATTACK)
	animation_player.play("attack")


func set_state(new_state: PlayerState) -> void:
	if animation_player.current_animation == "attack" or new_state == _state:
		return
	_state = new_state
	match _state:
		PlayerState.ON_LADDER:
			animation_player.play("climbing")
		PlayerState.IDLE:
			animation_player.play("idle")
		PlayerState.RUN:
			animation_player.play("run")
		PlayerState.JUMP:
			animation_player.play("jump")
		PlayerState.FALL:
			animation_player.play("jump")
			collision_shape_2d.disabled = true
		PlayerState.HURT:
			apply_hurt_jump()


func calculate_state() -> void:
	if _state == PlayerState.HURT:
		return
	if is_on_floor():
		if velocity.x == 0:
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.RUN)
	elif _on_ladder:
		set_state(PlayerState.ON_LADDER)
	else:
		if velocity.y > 0:
			set_state(PlayerState.FALL)
		elif velocity.y < 0:
			set_state(PlayerState.JUMP)


func on_ladder(value: bool) -> void:
	_on_ladder = value
	set_state(PlayerState.ON_LADDER)


func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		collision_shape_2d.disabled = true
		if _on_ladder:
			animation_player.play("climbing")


func _on_hit_box_area_entered(area: Area2D) -> void:
	if _invincible:
		return
	SignalManager.on_player_hit.emit()
	SoundManager.play_clip(sound, SoundManager.SOUND_DAMAGE)
	go_invincible()
	set_state(PlayerState.HURT)


func go_invincible() -> void:
	_invincible = true
	invincible_player.play("invincible")
	invincible_timer.start()


func apply_hurt_jump() -> void:
	animation_player.play("hurt")
	velocity.x = KNOCKBACK * sign(velocity.x)
	velocity.y = HURT_JUMP_VELOCITY
	hurt_timer.start()


func _on_invincible_timer_timeout() -> void:
	_invincible = false
	invincible_player.stop()


func _on_hurt_timer_timeout() -> void:
	set_state(PlayerState.IDLE)


func on_player_died() -> void:
	death_sprite.flip_h = sprite_2d.flip_h
	sprite_2d.hide()
	death_sprite.show()
	death_sprite.play("death")
