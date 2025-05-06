extends Node

signal on_enemy_hit
signal on_player_hit(dmg: int)

signal on_create_object(
	pos: Vector2,
	ob_type: Constants.ObjectType,
)

signal on_create_projectile(
	position: Vector2, 
	direction: Vector2, 
	speed: float,
	flip_sprite: bool,
	projectile_type: BaseProjectile.ProjectileType,
	)

signal on_coin_collected
signal on_create_slime(position: Vector2)
signal on_exit_reached
signal on_game_over
signal on_key_collected
signal on_ladder(val: bool)
