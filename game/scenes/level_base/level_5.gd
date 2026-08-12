extends LevelBase

const LIFE_SPAWN: Vector2 = Vector2(216, 216)

var _extra_life_spawned: bool = false

@onready var torches: Node2D = get_node("Torches")


func _process(delta: float) -> void:
	super._process(delta)
	if not _extra_life_spawned:
		check_torches()


func check_torches() -> void:
	if torches.get_child_count() == 0:
		_extra_life_spawned = true
		SignalManager.on_create_object.emit(LIFE_SPAWN, Constants.ObjectType.EXTRA_LIFE)
