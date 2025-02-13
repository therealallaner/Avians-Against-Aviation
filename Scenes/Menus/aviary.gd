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
		if Check_Unlocked(x):
			currentBird = currentBird1
			select1.text = "Selected"
			if Global.birdUnlocks2[Global.currentBird2]:
				select2.text = "Select"
			if Global.birdUnlocks3[Global.currentBird3]:
				select3.text = "Select"
			Global.currentBird = Global.currentBird1
			player.Change_Bird(player.birddict[Global.currentBird])
		
	elif x == 2:
		if Check_Unlocked(x):
			currentBird = currentBird2
			if Global.birdUnlocks1[Global.currentBird1]:
				select1.text = "Select"
			select2.text = "Selected"
			if Global.birdUnlocks3[Global.currentBird3]:
				select3.text = "Select"
			Global.currentBird = Global.currentBird2
			player.Change_Bird(player.birddict[Global.currentBird])
		
	elif x == 3:
		if Check_Unlocked(x):
			currentBird = currentBird3
			if Global.birdUnlocks1[Global.currentBird1]:
				select1.text = "Select"
			if Global.birdUnlocks2[Global.currentBird2]:
				select2.text = "Select"
			select3.text = "Selected"
			Global.currentBird = Global.currentBird3
			player.Change_Bird(player.birddict[Global.currentBird])
	
	
func Check_Unlocked(x):
	if x == 1:
		if select1.text == "Buy":
			if Global.mossiesInStock1 >= 100:
				Global.birdUnlocks1[Global.currentBird1] = true
				Global.mossiesInStock1 -= 100
				birdCard1.mossiesLabel.text = str(Global.mossiesInStock1) + "/100"
				select1.text = "Select"
				Global.Save_Game()
		else:
			return true
	elif x == 2:
		if select2.text == "Buy":
			if Global.mossiesInStock2 >= 250:
				Global.birdUnlocks2[Global.currentBird2] = true
				Global.mossiesInStock2 -= 250
				birdCard2.mossiesLabel.text = str(Global.mossiesInStock1) + "/250"
				select2.text = "Select"
				Global.Save_Game()
		else:
			return true
	elif x == 3:
		if select3.text == "Buy":
			if Global.mossiesInStock3 >= 625:
				Global.birdUnlocks3[Global.currentBird3] = true
				Global.mossiesInStock3 -= 625
				birdCard3.mossiesLabel.text = str(Global.mossiesInStock1) + "/625"
				select3.text = "Select"
				Global.Save_Game()
		else:
			return true
	
func _on_select_1_pressed():
	Bird_Select(1)
	

func _on_select_2_pressed():
	Bird_Select(2)


func _on_select_3_pressed():
	Bird_Select(3)


func _on_back_pressed():
	get_parent().Menu_Close(get_parent().aviary,get_parent().mainMenu)
	await(get_tree().create_timer(.1).timeout)
	Global.mouseHovering = false
	Global.Save_Game()


