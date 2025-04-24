extends Node

signal on_enemy_hit
signal on_player_hit(dmg: int)

signal on_create_object(
	pos: Vector2,
	ob_type: Constants.ObjectType,
)

signal on_coin_collected
signal on_exit_reached
signal on_key_collected
signal on_ladder(val: bool)
