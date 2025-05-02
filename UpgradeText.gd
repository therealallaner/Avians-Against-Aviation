extends Node

var scoreMultiplier = 1

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

var upgradeText = {
'Score Multiplier': 
	'Your points are multiplied
	by ' + str(scoreMultiplierLevels[int(Global.upgrades['Score Multiplier'])]) + 
	' at level ' + str(Global.upgrades['Score Multiplier']) + '.',
	
'Energy Shield': 
	'You have an Energy Shield
	that gives you an extra ' + str(energyShieldLevels[int(Global.upgrades['Energy Shield'])]) + ' HP
	at level ' + str(Global.upgrades['Energy Shield']) + '.',
	
'Better Heals': 'Blank',
'Vulture': 'Blank',
'Coming Soon': 'This upgrade will be unlocked in the full game.'
}


func Upgrade_Activator(x):
	var y = x.upgradeNumber
	
	if y == 1:
		Score_Multiplier()
		
	elif y == 2:
		Energy_Shield()
		
	elif y == 3:
		Better_Heals()
		
	else:
		pass
		
	x.queue_free()
	
func Score_Multiplier():
	scoreMultiplier = scoreMultiplierLevels[Global.upgrades['Score Multiplier']]
	print('New High Score!')
	await(get_tree().create_timer(15).timeout)
	scoreMultiplier = 1
	
	
func Energy_Shield():
	print('Gained ES')
	pass
	# Give player ES equal to what the level says
	
	var gameScene = get_tree().root.get_node("GameScene")
	gameScene.player.ES = energyShieldLevels[Global.upgrades['Energy Shield']]
	
func Better_Heals():
	print('Heals Over Time')
	pass
