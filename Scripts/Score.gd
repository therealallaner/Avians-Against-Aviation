extends Control

@onready var scoreLabel = $Label
@onready var gameScene = get_parent().get_parent()


func _ready():
	scoreLabel.text = "Score: " + str(gameScene.score)
	

func _process(delta):
	scoreLabel.text = "Score: " + str(gameScene.score)
