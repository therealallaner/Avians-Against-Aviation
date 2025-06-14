extends Node

@onready var upgrade1 = preload("res://Scenes/Main/score_multiplier.tscn")
@onready var upgrade2 = preload("res://Scenes/Main/energy_shield.tscn")
@onready var upgrade3 = preload("res://Scenes/Main/better_heals.tscn")
@onready var upgrade4 = preload("res://Scenes/Main/vulture.tscn")
@onready var upgrade5 = preload("res://Scenes/Main/crit_hit.tscn")
@onready var upgrade6 = preload("res://Scenes/Main/mossy_magnet.tscn")


@onready var upgrades = [
	]


#func _ready():
#	if Global.demo:
#		upgrades = [upgrade1, upgrade2, upgrade3]
#		pass

func _ready():
	Upgrade_Availability()


func Spawn_Upgrade():
#	if randf() >= 0.75:
#		print('This spawn failed')
#		return
	if upgrades:
		var upgrade = Global.Random_List(upgrades)
		var instance = upgrade.instantiate()
		add_child(instance)
		instance.position.x = 2000
		instance.position.y = randf_range(150,930)
	#	instance.target.x = (s.position.x - 500)
	#	instance.target.y = s.position.y
	#	instance.waitTimer.wait_time = randf_range(.9,1.1)

func Upgrade_Availability():
	upgrades = []
	if Global.upgrades['Score Multiplier'] >= 1:
		upgrades.append(upgrade1)
	if Global.upgrades['Energy Shield'] >= 1:
		upgrades.append(upgrade2)
	if Global.upgrades['Better Heals'] >= 1:
		upgrades.append(upgrade3)
		
	if Global.demo:
		return
		
	if Global.upgrades['Vulture'] >= 1:
		upgrades.append(upgrade4)
	if Global.upgrades['Mossy Magnet'] >= 1:
		upgrades.append(upgrade6)
