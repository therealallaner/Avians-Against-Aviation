extends Node



var gameMenu = true
var mouseHovering = false
var highScore = 0
var currentDamage = 1
var masterVolume: float = 1.0
var musicVolume: float = 1.0
var mossiesInStock1 = 0
var mossiesInStock2 = 0
var mossiesInStock3 = 0

var currentBird = "blackBird1"
var currentBird1 = "blackBird1"
var currentBird2 = "blackBird2"
var currentBird3 = "blackBird3"

var birdUnlocks1 = {
	"blackBird1": true,
	"greenBird1": false,
	"redBird1": false,
	"pinkBird1": false,
	"yellowBird1": false
}
var birdUnlocks2 = {
	"blackBird2": true,
	"greenBird2": false,
	"redBird2": false,
	"pinkBird2": false,
	"yellowBird2": false,
	"blueBird2": false,
	"purpleBird2": false
}

var birdUnlocks3 = {
	"blackBird3": true,
	"greenBird3": false,
	"redBird3": false,
	"pinkBird3": false,
	"yellowBird3": false,
	"blueBird3": false,
	"purpleBird3": false
}

var playerStats = {
	"HighScore": 0,
	"LifetimeScore": 0,
	"LifetimeMossies": 0,
	"CritChance": .01,
}


func Start_Game():
	var gameScene = get_tree().root.get_node("GameScene")
	
	gameMenu = false
	gameScene.player.visibility.show()
	gameScene.mainMenu.hide()
	gameScene.waveController.Next_Wave()
	gameScene.waveController.mossyTimer.start()
	gameScene.GUI.show()

func Game_Over():
	var gameScene = get_tree().root.get_node("GameScene")
	
	mossiesInStock1 += gameScene.bird1Mossies
	mossiesInStock2 += gameScene.bird2Mossies
	mossiesInStock3 += gameScene.bird3Mossies
	if gameScene.score > highScore:
		highScore = gameScene.score
		
	gameScene.player.visibility.hide()
	gameScene.gameOver.Set_Game_Over_Screen()
	gameScene.gameOver.show()
	gameScene.waveController.wave = 0
	gameScene.waveController.mossyTimer.stop()
	Save_Game()
	Engine.time_scale = .15
	
func Deal_Damage(b):
	var gameScene = get_tree().root.get_node("GameScene")
	var damage = currentDamage
	var x = randf()
	if x <= playerStats["CritChance"]:
		damage = currentDamage*2
	b.HP -= damage
	var hp = b.HP
	gameScene.GUI.Update_Boss_HP(hp)
	
func Save_Game():
	var gameScene = get_tree().root.get_node("GameScene")
	gameScene.saver.Save_Game()
	
func Random_List(list):
	return list[randi() % list.size()]
