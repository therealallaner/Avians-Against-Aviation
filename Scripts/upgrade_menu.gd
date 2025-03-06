extends Control


@onready var gameScene = get_parent().get_parent()

@onready var scoreMultiplier = $VBoxContainer/GridContainer/ScoreMultiplier
@onready var energyShield = $VBoxContainer/GridContainer/EnergyShield
@onready var betterHeals = $VBoxContainer/GridContainer/BetterHeals
@onready var vulture = $VBoxContainer/GridContainer/Vulture

@onready var info = $Info
@onready var infoLabel = $Info/Label


@onready var upgrades = [
	scoreMultiplier,
	energyShield,
	betterHeals,
	vulture
]

func _ready():
	pass


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
	
	
