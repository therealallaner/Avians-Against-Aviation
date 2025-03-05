extends Node

var x = 1.4
var level = 13
var es = 25


var doublePointLevels = {
	1: 1,
	2: 1.5,
	3: 2
}

var upgradeText = {
'Double Points': 'Your points are multiplied by ' + str(doublePointLevels[int(Global.upgrades['Double Points'])]) + ' at level ' + str(Global.upgrades['Double Points']) + '.',
'Energy Shield': 'You have an Energy Shield that gives you an extra ' + str(es) + ' HP at level ' + str(Global.upgrades['Energy Shield']) + '.',
}


