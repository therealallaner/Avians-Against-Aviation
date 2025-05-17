extends Node



var gameMenu = true
var mouseHovering = false
var currentDamage = 1
var masterVolume: float = 0.51
var musicVolume: float = 0.51
var sfxVolume: float = 0.51
var mossiesInStock = 0

var justOpened = true
var demo = false

var currentBird = "blackBird1"
var currentBird1 = "blackBird1"
var currentBird2 = "blackBird2"
var currentBird3 = "blackBird3"

var birdUnlocks = {
	"blackBird1": true,
	"greenBird1": false,
	"redBird1": false,
	"pinkBird1": false,
	"yellowBird1": false,
	
	"blackBird2": true,
	"greenBird2": false,
	"redBird2": false,
	"pinkBird2": false,
	"yellowBird2": false,
	"blueBird2": false,
	"purpleBird2": false,
	
	"blackBird3": true,
	"greenBird3": false,
	"redBird3": false,
	"pinkBird3": false,
	"yellowBird3": false,
	"blueBird3": false,
	"purpleBird3": false
}

var playerStats = {
	"High Score": 0,
	"Lifetime Score": 0,
	"Mosquitos Eaten": 0,
	"Planes Hit": 0,
	"Power-Ups Collected": 0,
	"Bosses Defeated": 0
}


var upgrades = {
	"Score Multiplier": 0,
	"Energy Shield": 0,
	"Better Heals": 0,
	"Vulture": 0,
	"Crit Hit": 0,
	"Mossy Magnet": 0,
	'Coming Soon':  0
}

var tipTriggers = {
	'hasTakenDamage': false,
	'hasDamagedBoss': false,
	'testTip': false
}


func Start_Game():
	var gameScene = get_tree().root.get_node("GameScene")
	
	gameMenu = false
	gameScene.player.visibility.show()
	gameScene.menu.Game_Start_Anim()
	gameScene.mainMenu.hide()
	gameScene.waveController.Next_Wave()
	#gameScene.GUI.show()
	gameScene.get_node("Menus/Aviary").hide()
	gameScene.get_node("Menus/Stats").hide()

func Game_Over():
	var gameScene = get_tree().root.get_node("GameScene")
	
	mossiesInStock += gameScene.mossies
	playerStats["Mosquitos Eaten"] += (gameScene.mossies)
	playerStats["Lifetime Score"] += gameScene.score
	if gameScene.score > playerStats["High Score"]:
		playerStats["High Score"] = gameScene.score
		
	gameScene.player.visibility.hide()
	gameScene.gameOver.Set_Game_Over_Screen()
	gameScene.gameOver.show()
	gameScene.waveController.wave = 0
	gameScene.waveController.mossyTimer.stop()
	Save_Game()
	Engine.time_scale = .15
	UpgradeText.scoreMultiplier = 1
	UpgradeText.healsOverTime = false
	
func Deal_Damage(b):
	var gameScene = get_tree().root.get_node("GameScene")
	var damage = currentDamage
#	var x = randf()
#	if x <= playerStats["Crit Chance"]:
#		damage = currentDamage*2
	b.HP -= damage
	var hp = b.HP
	gameScene.GUI.Update_Boss_HP(hp)
	
func Save_Game():
	var gameScene = get_tree().root.get_node("GameScene")
	gameScene.saver.Save_Game()
	
func Random_List(list):
	return list[randi() % list.size()]
