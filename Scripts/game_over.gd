extends Control


@onready var gameScene = get_parent().get_parent()
@onready var gameOver = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var mainMenu = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Button2

	
	
func Set_Game_Over_Screen():
	var mossies = gameScene.bird1Mossies
	if gameScene.player.currentBird in gameScene.player.bird2:
		mossies = gameScene.bird2Mossies
	if gameScene.player.currentBird in gameScene.player.bird3:
		mossies = gameScene.bird3Mossies
		
	gameOver.text = "Good Job!
	Your score was " + str(gameScene.score) + "
	and you collected 
	" + str(mossies) + " mosquitos!"


func _on_button_2_pressed():
	get_tree().reload_current_scene()
	Global.gameMenu = true
	gameScene.mainMenu.show()
	gameScene.GUI.hide()

