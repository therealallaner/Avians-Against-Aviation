extends Node


@onready var waveController = get_parent()
@onready var bossHPBar = get_parent().get_parent().get_node("Menus").get_node("GUI").get_node("BossHP")
@onready var gui = get_parent().get_parent().get_node("Menus").get_node("GUI")
@onready var mossyBoss = preload("res://Scenes/Bosses/mosquito_boss.tscn")
@onready var stealthBoss = preload("res://Scenes/Bosses/stealth_bomber.tscn")
@onready var heliBoss = preload("res://Scenes/Bosses/helicopter.tscn")
@onready var dragonBoss = preload("res://Scenes/Bosses/dragon_boss.tscn")
@onready var airshipBoss = preload("res://Scenes/Bosses/airship_boss.tscn")

@onready var bosses = [
	mossyBoss,
	stealthBoss,
	heliBoss
]

var bossCycle = 0

func _ready():
	if Global.demo:
		bosses = [mossyBoss,stealthBoss]

func Spawn_Boss(x):
	var b = bosses[0]
	var instance = b.instantiate()
	bosses.erase(b)
	bosses.append(b)
	add_child(instance)
	instance.position = Vector2(2020,540)
	'This part for some reason doesnt work and wont scale up the HP'
	instance.HP = snapped((instance.HP * x),1)
	bossHPBar.show()
	gui.Boss_HP_Bar()
	bossHPBar.max_value = instance.HP
	bossHPBar.value = instance.HP
	var targetX = instance.position.x - 350
	var targetY = instance.position.y
	instance.target = Vector2(targetX,targetY)
	
	'This is trying to add a cycle counter to the boss waves so I can add multiplicative
	or exponential rewards and scaling for cycling through the bosses each more than once.'
	
	bossCycle += 1
	if bossCycle >= len(bosses):
		bossCycle = 0
		waveController.bossWaveCycle += 1
		waveController.bossHPX *= 1.25
