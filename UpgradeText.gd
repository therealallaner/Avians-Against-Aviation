extends Node

var x = 1.4
var level = 13
var es = 25


var scoreMultiplierLevels = {
	1: 1,
	2: 1.5,
	3: 2
}

var upgradeText = {
'Score Multiplier': 'Your points are multiplied by ' + str(scoreMultiplierLevels[int(Global.upgrades['Score Multiplier'])]) + ' at level ' + str(Global.upgrades['Score Multiplier']) + '.',
'Energy Shield': 'You have an Energy Shield that gives you an extra ' + str(es) + ' HP at level ' + str(Global.upgrades['Energy Shield']) + '.',
'Better Heals': 'Blank',
'Vulture': 'Blank',
'Coming Soon': 'Blank'
}


