extends LevelBase

@onready var hidden_ladder: Ladder = $Ladders/HiddenLadder
@onready var torches: Node2D = get_node("Torches")

func _process(delta: float) -> void:
	super._process(delta)
	check_torches()


func check_torches() -> void:
	if torches.get_child_count() == 0:
		hidden_ladder.show()
		hidden_ladder.set_disabled_status(false)
