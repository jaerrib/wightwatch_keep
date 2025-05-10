class_name Player extends CharacterBody2D

enum PlayerState { IDLE, RUN, JUMP, FALL, ON_LADDER }

const CLIMB_SPEED: float = 300.0
const FALLEN_OFF: float = 325.0
const GRAVITY: float = 690.0
const JUMP_VELOCITY: float = -175.0
const MAX_FALL: float = 400.0
const RUN_SPEED: float = 120.0

@export var right_collision_position: Vector2 = Vector2(9,0)
@export var left_collision_position: Vector2 = Vector2(-9,0)

var _state: PlayerState = PlayerState.IDLE
var _on_ladder: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: Area2D = $HitBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sword_hit_box: Area2D = $SwordHitBox
@onready var collision_shape_2d: CollisionShape2D = $SwordHitBox/CollisionShape2D


func _ready() -> void:
	SignalManager.on_ladder.connect(on_ladder)


func _physics_process(delta: float) -> void:
	fallen_off()
	if not is_on_floor() and !_on_ladder:
		velocity.y += GRAVITY * delta
	get_input(delta)
	calculate_state()
	set_sword_hit_box_position()
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
	if _on_ladder:
		if Input.is_action_pressed("up"):
			velocity.y = -CLIMB_SPEED * delta * 10
			set_state(PlayerState.ON_LADDER)
		elif Input.is_action_pressed("down"):
			velocity.y = CLIMB_SPEED * delta * 10
			set_state(PlayerState.ON_LADDER)
		else:
			velocity.y = 0
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("attack"):
			SoundManager.play_clip(sound, SoundManager.SOUND_PLAYER_ATTACK)
			animation_player.play("attack")
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func set_state(new_state: PlayerState) -> void:
	if new_state == _state:
		return
	if _state == PlayerState.FALL:
		if new_state == PlayerState.IDLE or new_state == PlayerState.RUN:
			#SoundManager.play_clip(sound, SoundManager.SOUND_LAND )
			pass
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


func calculate_state() -> void:
	#if _state == PlayerState.HURT:
		#return
	if is_on_floor():
		if velocity.x == 0:
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.RUN)
	if _on_ladder:
		set_state(PlayerState.ON_LADDER)
	else:
		if velocity.y > 0:
			set_state(PlayerState.FALL)
		else:
			if velocity.y < 0:
				set_state(PlayerState.JUMP)



func on_ladder(value: bool) -> void:
	_on_ladder = value


func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		collision_shape_2d.disabled = true
		if _on_ladder:
			animation_player.play("climbing")


func _on_hit_box_area_entered(area: Area2D) -> void:
	SignalManager.on_player_hit.emit()
