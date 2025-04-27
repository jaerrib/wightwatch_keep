extends CharacterBody2D

const GRAVITY: float = 690.0

var _player_ref: Player


func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)


func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()	


func _on_right_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		velocity.x += _player_ref.velocity.x


func _on_right_area_exited(area: Area2D) -> void:
	velocity.x = 0


func _on_left_side_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		velocity.x += _player_ref.velocity.x


func _on_left_side_area_exited(area: Area2D) -> void:
	velocity.x = 0
