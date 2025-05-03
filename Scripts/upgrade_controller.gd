extends Node

@onready var upgrade1 = preload("res://Scenes/Main/score_multiplier.tscn")
@onready var upgrade2 = preload("res://Scenes/Main/energy_shield.tscn")
@onready var upgrade3 = preload("res://Scenes/Main/better_heals.tscn")


@onready var upgrades = [
	upgrade2,
	upgrade3
	]


func _ready():
	if Global.demo:
		upgrades = [upgrade1, upgrade2, upgrade3]
		pass


func Spawn_Upgrade():
	var upgrade = Global.Random_List(upgrades)
	var instance = upgrade.instantiate()
	add_child(instance)
	instance.position.x = 2000
	instance.position.y = randf_range(150,930)
#	instance.target.x = (s.position.x - 500)
#	instance.target.y = s.position.y
#	instance.waitTimer.wait_time = randf_range(.9,1.1)

