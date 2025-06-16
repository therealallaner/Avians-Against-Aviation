extends Control


@onready var gameScene = get_parent().get_parent()

@onready var scoreMultiplier = $VBoxContainer/GridContainer/ScoreMultiplier
@onready var energyShield = $VBoxContainer/GridContainer/EnergyShield
@onready var betterHeals = $VBoxContainer/GridContainer/BetterHeals
@onready var vulture = $VBoxContainer/GridContainer/Vulture
@onready var critChance = $VBoxContainer/GridContainer/CriticalChance
@onready var mossyMagnet = $VBoxContainer/GridContainer/MossyMagnet

@onready var info = $Info
@onready var infoLabel = $Info/Label
@onready var mossyLabel = $VBoxContainer/HBoxContainer/Mossies

@onready var buyWindow = $BuyWindow
@onready var buyLabel = $BuyWindow/VBoxContainer/BuyLabel


@onready var upgrades = [
	scoreMultiplier,
	energyShield,
	betterHeals,
	vulture,
	critChance,
	mossyMagnet
]

@onready var demoUpgrades = [
	scoreMultiplier,
	energyShield,
	betterHeals
]

@onready var testList = $VBoxContainer/GridContainer.get_children()

var upgradeNumber : int

func _ready():
	mossyLabel.text = 'Mosquitos: ' + str(Global.mossiesInStock)
	if Global.demo:
		upgrades = demoUpgrades
		var upgradeCards = $VBoxContainer/GridContainer.get_children()
		for c in upgradeCards:
			if c in upgrades:
				pass
			else:
				c.Name = 'Coming Soon'


func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true
		
		
func Update_Store():
	pass
		

func _on_back_pressed():
	get_parent().Menu_Close(get_parent().upgradeMenu,get_parent().mainMenu)
	await(get_tree().create_timer(.1).timeout)
	Global.mouseHovering = false
	Global.Save_Game()
	await(get_tree().create_timer(.1).timeout)
	gameScene.player.show()
	
	
	gameScene.menu.aviary.mossyLabel.text = 'Mosquitos: ' + str(Global.mossiesInStock)
	
	


func _on_no_pressed():
	buyWindow.hide()


func _on_yes_pressed():
	var number = upgradeNumber - 1
	upgrades[number].upgrade()
	buyWindow.hide()
	
