extends Control


@onready var birdCard1 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BirdCard
@onready var birdCard2 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/BirdCard2
@onready var birdCard3 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/BirdCard3
@onready var select1 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Select1
@onready var select2 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Select2
@onready var select3 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Select3


@onready var currentBird = "1"
@onready var currentBird1 = birdCard1.options.selected
@onready var currentBird2 = birdCard2.options.selected
@onready var currentBird3 = birdCard3.options.selected

@onready var player = get_parent().get_parent().get_node("HappyBird")

func _ready():
	birdCard1.Change_Sprite(currentBird1)
	birdCard2.Change_Sprite(currentBird2)
	birdCard3.Change_Sprite(currentBird3)
		
func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true

func Bird_Select(x):
	if x == 1:
		currentBird = currentBird1
		select1.text = "Selected"
		select2.text = "Select"
		select3.text = "Select"
		Global.currentBird = Global.currentBird1
		player.Change_Bird(player.birddict[Global.currentBird])
		
	elif x == 2:
		currentBird = currentBird2
		select1.text = "Select"
		select2.text = "Selected"
		select3.text = "Select"
		Global.currentBird = Global.currentBird2
		player.Change_Bird(player.birddict[Global.currentBird])
		
	elif x == 3:
		currentBird = currentBird3
		select1.text = "Select"
		select2.text = "Select"
		select3.text = "Selected"
		Global.currentBird = Global.currentBird3
		player.Change_Bird(player.birddict[Global.currentBird])
	
	
func _on_select_1_pressed():
	Bird_Select(1)
	

func _on_select_2_pressed():
	Bird_Select(2)


func _on_select_3_pressed():
	Bird_Select(3)


func _on_back_pressed():
	get_parent().Menu_Close(get_parent().aviary,get_parent().mainMenu)


