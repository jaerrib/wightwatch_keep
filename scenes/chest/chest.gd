class_name Chest extends CharacterBody2D

@export var drop_type: Constants.ObjectType = Constants.ObjectType.COIN

var _can_collect: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_hit_box_area_entered(area: Area2D) -> void:
	if !_can_collect:
		return
	animated_sprite_2d.play("open")
	var spawn_pos: Vector2
	if drop_type in [Constants.ObjectType.COIN, Constants.ObjectType.HEART]:
		for pos in range(-8, 10, 4):
			spawn_pos = Vector2(global_position.x + pos, global_position.y)
			SignalManager.on_create_object.emit(spawn_pos, drop_type)
	else:
		if drop_type == Constants.ObjectType.HEART_LARGE:
			SignalManager.on_create_object.emit(global_position, drop_type)
	_can_collect = false
