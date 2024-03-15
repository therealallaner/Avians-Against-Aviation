extends Control

@onready var scoreLabel = $VBoxContainer/Label
@onready var mossyLabel = $VBoxContainer/Label2
@onready var gameScene = get_parent().get_parent()


func _ready():
	scoreLabel.text = "Score: " + str(gameScene.score)
	mossyLabel.text = "Mosquitos: " + str(gameScene.mossiesEaten)
	

func _process(delta):
	scoreLabel.text = "Score: " + str(gameScene.score)
	mossyLabel.text = "Mosquitos: " + str(gameScene.mossiesEaten)
