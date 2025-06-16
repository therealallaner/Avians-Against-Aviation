extends Node

@onready var upgradeImage1 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 1/Upgrade 1 Visual v5.png")
@onready var upgradeProgress1 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 1/Upgrade 1 Visual Progress v5.png")
@onready var upgradeBG1 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 1/Upgrade 1 Visual BG v5.png")

@onready var upgradeImage3 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 3/Upgrade 3 Visual v1.png")
@onready var upgradeProgress3 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 3/Upgrade 3 Progress v1.png")
@onready var upgradeBG3 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 3/Upgrade 3 BG v1.png")

@onready var upgradeImage4 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 4/Upgrade 4 Visual.png")
@onready var upgradeProgress4 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 4/Upgrade 4 Progress.png")
@onready var upgradeBG4 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 4/Upgrade 4 BG.png")

@onready var upgradeImage6 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 6/Upgrade 6 Visual.png")
@onready var upgradeProgress6 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 3/Upgrade 3 Progress v1.png")
@onready var upgradeBG6 = preload("res://Assets/Upgrade Assets/Upgrade Icons/Upgrade Progress Textures/Upgrade 3/Upgrade 3 BG v1.png")
var scoreMultiplier = 1
var healsOverTime = false
var vultureActive = false
var magnetActive = false

var upgradeCost = {
	1: 50,
	2: 55,
	3: 65,
	4: 80,
	5: 100,
	6: 125,
	7: 155,
	8: 190,
	9: 230,
	10: 275,
	11: 325,
	12: 380,
	13: 440,
	14: 505,
	15: 575,
	16: 650,
	17: 730,
	18: 815,
	19: 905,
	20: 1000
}

var scoreMultiplierLevels = {
	0: 1,
	1: 2,
	2: 3,
	3: 4,
	4: 5,
	5: 6,
	6: 7,
	7: 8,
	8: 9,
	9: 10,
	10: 11,
	11: 12,
	12: 13,
	13: 14,
	14: 15,
	15: 16,
	16: 17,
	17: 18,
	18: 19,
	19: 20,
	20: 25
}

var energyShieldLevels = {
	0: 0,
	1: 5,
	2: 10,
	3: 15,
	4: 20,
	5: 25,
	6: 30,
	7: 35,
	8: 40,
	9: 45,
	10: 50,
	11: 55,
	12: 60,
	13: 65,
	14: 70,
	15: 75,
	16: 80,
	17: 85,
	18: 90,
	19: 95,
	20: 100
}

var betterHealsLevels = {
	0: 1.0,
	1: 1.5,
	2: 2.0,
	3: 2.5,
	4: 3.0,
	5: 3.0,
	6: 3.5,
	7: 4.0,
	8: 4.5,
	9: 4.5,
	10: 5.0,
	11: 5.5,
	12: 6.0,
	13: 6.0,
	14: 6.5,
	15: 7.0,
	16: 7.5,
	17: 7.5,
	18: 8.0,
	19: 9.0,
	20: 10.0
}

var betterHealsLevelsTime = {
	0: 1,
	1: 1,
	2: 1,
	3: 1,
	4: 1,
	5: 2,
	6: 2,
	7: 2,
	8: 2,
	9: 3,
	10: 3,
	11: 3,
	12: 3,
	13: 4,
	14: 4,
	15: 4,
	16: 4,
	17: 5,
	18: 5,
	19: 5,
	20: 5
}

var vultureTime = {
	0: 0.0,
	1: 5.0,
	2: 5.5,
	3: 6.0,
	4: 6.5,
	5: 7.0,
	6: 8.0,
	7: 8.5,
	8: 9.0,
	9: 9.5,
	10: 10.0,
	11: 10.5,
	12: 11.0,
	13: 11.5,
	14: 12.0,
	15: 12.5,
	16: 13.0,
	17: 13.5,
	18: 14.0,
	19: 14.5,
	20: 15.0
}

var critChance = {
	0: 0.0,
	1: 0.01,
	2: 0.02,
	3: 0.03,
	4: 0.04,
	5: 0.05,
	6: 0.06,
	7: 0.07,
	8: 0.08,
	9: 0.09,
	10: 0.11,
	11: 0.11,
	12: 0.12,
	13: 0.13,
	14: 0.14,
	15: 0.15,
	16: 0.16,
	17: 0.17,
	18: 0.18,
	19: 0.19,
	20: 0.20
}

var mossyMagnetSize = {
	0: 0.0,
	1: 100.0,
	2: 105.0,
	3: 110.735,
	4: 117.301,
	5: 124.790,
	6: 133.303,
	7: 142.950,
	8: 153.852,
	9: 166.140,
	10: 179.960,
	11: 195.473,
	12: 212.857,
	13: 232.310,
	14: 254.057,
	15: 278.345,
	16: 305.443,
	17: 335.647,
	18: 369.280,
	19: 406.697,
	20: 445.0
}
func Upgrade_Text(Name):
	
	var upgradeText = {
	'Score Multiplier': 
		'Your points are multiplied
		by ' + str(scoreMultiplierLevels[int(Global.upgrades['Score Multiplier'])]) + 
		' at level ' + str(Global.upgrades['Score Multiplier']) + '.',
		
	'Energy Shield': 
		'You have an Energy Shield
		that gives you an extra ' + str(energyShieldLevels[int(Global.upgrades['Energy Shield'])]) + ' HP
		at level ' + str(Global.upgrades['Energy Shield']) + '.',
		
	'Better Heals': 
		'Whenever you eat a mosquito,
		you gain ' + str(betterHealsLevels[int(Global.upgrades['Better Heals'])]) + ' HP
		per second for ' + str(betterHealsLevelsTime[int(Global.upgrades['Better Heals'])]) + ' second(s)
		per mosquito at level ' + str(Global.upgrades['Better Heals']) + '.',

	'Vulture': 
		'You become an invincible Vulture 
		for ' + str(vultureTime[int(Global.upgrades['Vulture'])]) + ' seconds at level ' + str(Global.upgrades['Vulture']) + '.',

	'Crit Chance': 
		'Your critical hit chance is '
		+ str((Global.critChance) * 100) + '% at level ' + str(Global.upgrades['Crit Chance']),

	'Mossy Magnet': 
		'You gain a magnetic field around you
		that pulls mosquitos towards you.
		This magnetic field becomes larger
		as you level it up.',

	'Coming Soon': 'This power-up will be unlocked in the full game.'
	}
	
	return upgradeText[Name]

func Upgrade_Activator(x):
	var y = x.upgradeNumber
	
	if y == 1:
		Score_Multiplier()
		
	elif y == 2:
		Energy_Shield()
		
	elif y == 3:
		Better_Heals()
		
	elif y == 4:
		Vulture()
		
	elif y == 6:
		Mossy_Magnet()
		
	else:
		pass
		
	x.queue_free()
	
func Score_Multiplier():
	scoreMultiplier = scoreMultiplierLevels[Global.upgrades['Score Multiplier']]
	Visualiser_Checker(1)
	GUI_Visualizer(upgradeImage1,upgradeProgress1,upgradeBG1,1)
	
	
func Energy_Shield():
	pass
	# Give player ES equal to what the level says
	
	var gameScene = get_tree().root.get_node("GameScene")
	gameScene.player.ES = energyShieldLevels[Global.upgrades['Energy Shield']]
	
	
func Better_Heals():
	healsOverTime = true
	Visualiser_Checker(3)
	GUI_Visualizer(upgradeImage3,upgradeProgress3,upgradeBG3,3)
	
	
func Vulture(timeout=false):
	if timeout:
		var gameScene = get_tree().root.get_node("GameScene")
		gameScene.player.Change_Bird(gameScene.player.currentBird,true)
		vultureActive = false
	else:
		var gameScene = get_tree().root.get_node("GameScene")
		gameScene.player.Change_Bird(gameScene.player.vulture,true)
		Visualiser_Checker(4)
		GUI_Visualizer(upgradeImage4,upgradeProgress4,upgradeBG4,4)
		vultureActive = true
	
	
func Mossy_Magnet(timeout=false):
	if timeout:
		var gameScene = get_tree().root.get_node("GameScene")
		gameScene.player.magnet.hide()
		gameScene.player.magnetAnim.hide()
		magnetActive = false
	else:
		var gameScene = get_tree().root.get_node("GameScene")
		Visualiser_Checker(6)
		GUI_Visualizer(upgradeImage6,upgradeProgress6,upgradeBG6,6)
		gameScene.player.magnet.show()
		gameScene.player.magnetShape.shape.radius = mossyMagnetSize[Global.upgrades['Mossy Magnet']]
		gameScene.player.magnetAnim.play("magnetized")
		gameScene.player.magnetAnim.show()
		magnetActive = true
	
	
	
func Visualiser_Checker(x):
	var GUI = get_tree().root.get_node("GameScene").GUI
	var children = GUI.upgradeCont.get_children()
	for child in children:
		if child.upgradeNumber == x:
			child.queue_free()
	
	
func GUI_Visualizer(pic,pro,bg,num):
	var gameScene = get_tree().root.get_node("GameScene")
	gameScene.GUI.Update_Upgrade_Visuals(pic,pro,bg,num)
