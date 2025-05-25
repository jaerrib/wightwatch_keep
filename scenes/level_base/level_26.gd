extends LevelBase

@onready var key: Area2D = $Key
@onready var ladder_1: Ladder = $Ladders/Ladder1
@onready var ladder_2: Ladder = $Ladders/Ladder2
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var camera_trigger: Area2D = $CameraTri640gger


func _ready() -> void:
	super._ready()
	level_setup()
	SignalManager.on_mage_wight_killed.connect(on_mage_wight_killed)
	SignalManager.on_warrior_wight_killed.connect(on_warrior_wight_killed)




func level_setup() -> void:
	key.hide()
	key.set_collision_mask_value(2, false)
	ladder_1.hide()
	ladder_2.hide()


func make_hidden_things_visible() -> void:
	key.show()
	key.set_collision_mask_value(2, true)
	#ladder_1.activate()
	#ladder_2.activate()
	ladder_1.toggle_status()
	ladder_2.toggle_status()
	ladder_1.show()	
	ladder_2.show()


func on_mage_wight_killed() -> void:
	make_hidden_things_visible()


func on_warrior_wight_killed() -> void:
	make_hidden_things_visible()


func _on_camera_trigger_area_entered(area: Area2D) -> void:
	camera_2d.limit_left = 320
	camera_2d.limit_right = 640
