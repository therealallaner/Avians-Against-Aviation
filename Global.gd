extends Node


var gameMenu = true
var mouseHovering = false
var highScore = 0
var mossiesInStock = 0

func Start_Game():
	var gameScene = get_tree().root.get_node("GameScene")
	
	gameMenu = false
	gameScene.mainMenu.hide()
	gameScene.waveController.Next_Wave()
	gameScene.waveController.mossyTimer.start()
	

func Game_Over():
	var gameScene = get_tree().root.get_node("GameScene")
	
	mossiesInStock += gameScene.mossiesEaten
	if gameScene.score > highScore:
		highScore = gameScene.score
		
	gameScene.gameOver.Set_Game_Over_Screen()
	gameScene.gameOver.show()
	gameScene.waveController.wave = 0
	gameScene.waveController.mossyTimer.stop()
	Engine.time_scale = .15


func Random_List(list):
	return list[randi() % list.size()]
