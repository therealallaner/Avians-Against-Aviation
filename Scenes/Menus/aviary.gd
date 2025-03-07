extends Control


@onready var gameScene = get_parent().get_parent()
@onready var birdCard1 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BirdCard
@onready var birdCard2 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BirdCard2
@onready var birdCard3 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BirdCard3
@onready var select1 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Select1
@onready var select2 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Select2
@onready var select3 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Select3
@onready var buyWindow = $BuyWindow
@onready var buyText = $BuyWindow/VBoxContainer/BuyText
@onready var mossyLabel = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/Mossies

@onready var birdCards = [birdCard1,birdCard2,birdCard3]

@onready var currentBird = "1"
#@onready var currentBird1 = birdCard1.options.selected
#@onready var currentBird2 = birdCard2.options.selected
#@onready var currentBird3 = birdCard3.options.selected
@onready var player = get_parent().get_parent().get_node("HappyBird")

var cost: int
var birdForSale: String

func _ready():
	if Global.demo:
		for x in [birdCard2,birdCard3]:
			birdCards.pop_back()
			x.hide()
			for c in x.carousel.get_children():
				c.queue_free()
	
	mossyLabel.text = 'Mosquitos: ' + str(Global.mossiesInStock)
		
func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true
		
		
func Tween_Birds(x):
	if x:
		pass
	else:
		for card in birdCards:
			pass

func _on_back_pressed():
	get_parent().Menu_Close(get_parent().aviary,get_parent().mainMenu)
	Tween_Birds(false)
	await(get_tree().create_timer(.1).timeout)
	gameScene.player.Check_Global()
	gameScene.player.Change_Bird(gameScene.player.currentBird)
	Global.mouseHovering = false
	Global.Save_Game()
	await(get_tree().create_timer(.1).timeout)
	gameScene.player.show()


func Test():
	print('This is the aviary')


func _on_no_pressed():
	buyWindow.hide()


func _on_yes_pressed():
	if Global.mossiesInStock >= cost:
		#Subtract Mosquitos
		Global.mossiesInStock -= cost
		mossyLabel.text = 'Mosquitos: ' + str(Global.mossiesInStock)
		#Buy the bird
		Global.birdUnlocks[birdForSale] = true
		#Equip the bird
		Global.currentBird = birdForSale
		#Update buttons on cards
		for c in birdCards:
			c.Update_Buttons()
		#Close buy window
		buyWindow.hide()
		
