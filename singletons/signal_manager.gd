extends Node

signal on_enemy_hit(points: int)
signal on_player_hit
signal on_player_died

signal on_create_falling_rock(position: Vector2)

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

signal on_coin_collected(points: int)
signal on_create_enemy(position: Vector2, enemy_type: Constants.EnemyType)
signal on_exit_reached
signal on_game_over
signal on_heart_spawn
signal on_heart_collected
signal on_key_collected
signal on_ladder(val: bool)
signal on_mage_wight_killed(position: Vector2)
signal on_warrior_wight_killed
signal on_score_updated(score: int)
signal on_stone_collected
