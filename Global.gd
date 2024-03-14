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
	get_tree().reload_current_scene()
	gameMenu = true
	gameScene.mainMenu.show()
	gameScene.waveController.wave = 0
	gameScene.waveController.mossyTimer.stop()


func Random_List(list):
	return list[randi() % list.size()]
