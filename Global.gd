extends Node


var gameMenu = true
var mouseHovering = false


func Start_Game():
	var gameScene = get_tree().root.get_node("GameScene")
	
	gameMenu = false
	gameScene.mainMenu.hide()
	

func Game_Over():
	var gameScene = get_tree().root.get_node("GameScene")
	get_tree().reload_current_scene()
	gameMenu = true
	gameScene.mainMenu.show()


func Random_List(list):
	return list[randi() % list.size()]
