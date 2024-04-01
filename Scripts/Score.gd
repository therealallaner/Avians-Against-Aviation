extends Control

@onready var scoreLabel = $VBoxContainer/Label
@onready var mossyLabel = $VBoxContainer/Label2
@onready var gameScene = get_parent().get_parent()


func _ready():
	scoreLabel.text = "Score: " + str(gameScene.score)
	var mossies = gameScene.bird1Mossies
	mossyLabel.text = "Mosquitos: " + str(mossies)
	

func _process(delta):
	scoreLabel.text = "Score: " + str(gameScene.score)
	var mossies = gameScene.bird1Mossies
	if gameScene.player.currentBird in gameScene.player.bird2:
		mossies = gameScene.bird2Mossies
	if gameScene.player.currentBird in gameScene.player.bird3:
		mossies = gameScene.bird3Mossies
	
	mossyLabel.text = "Mosquitos: " + str(mossies)
