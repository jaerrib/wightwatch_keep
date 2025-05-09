extends CharacterBody2D

var _can_collect: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_hit_box_area_entered(area: Area2D) -> void:
	if !_can_collect:
		return
	animated_sprite_2d.play("open")
	var spawn_pos: Vector2
	for pos in range(-8, 10, 4):
		spawn_pos = Vector2(global_position.x + pos, global_position.y)
		SignalManager.on_create_object.emit(spawn_pos, Constants.ObjectType.COIN)
	_can_collect = false
