extends Control


@onready var birdCard1 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BirdCard
@onready var birdCard2 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BirdCard2
@onready var birdCard3 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BirdCard3

@onready var currentBird = currentBird1
@onready var currentBird1 = birdCard1.options.selected
@onready var currentBird2 = birdCard2.options.selected
@onready var currentBird3 = birdCard3.options.selected


func _ready():
	birdCard1.Change_Sprite(currentBird1)
	birdCard2.Change_Sprite(currentBird2)
	birdCard3.Change_Sprite(currentBird3)
