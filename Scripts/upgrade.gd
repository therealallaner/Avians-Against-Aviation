extends Control


@export var Icon : Texture2D
@export var Name : String
@export var Number : int

@onready var upgradeMenu = get_parent().get_parent().get_parent()
@onready var upgradeName = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Name
@onready var upgradeIcon = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/Icon
@onready var upgradeLevel = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/VBoxContainer/Level
@onready var upgradeCost = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/VBoxContainer/Buy

var currentLevel = 0
var cost = 50

var maxLevel = 20




func _ready():
	
	
	if Global.demo:
		maxLevel = 5
		if currentLevel > maxLevel:
			currentLevel = 5
			
			
	upgradeName.text = Name
		
	
	if Name == 'Coming Soon':
		upgradeLevel.text = 'N/A'
		upgradeCost.text = 'N/A'
		upgradeCost.disabled = true
	else:
		upgradeIcon.texture = Icon
		currentLevel = Global.upgrades[Name]
		upgradeLevel.text = str(currentLevel) + '/' + str(maxLevel)
		if currentLevel < maxLevel:
			cost = int(UpgradeText.upgradeCost[currentLevel + 1])
			upgradeCost.text = 'Cost ' + str(cost) + 'm'
		elif currentLevel >= maxLevel:
			currentLevel = maxLevel
			cost = 'N/A'
			upgradeCost.text = 'Maxed'
			upgradeCost.disabled = true
		
	
	#$Wave.text = 'Wave: ' + str(x)


func _on_info_mouse_entered():
	upgradeMenu.infoLabel.text = UpgradeText.Upgrade_Text(Name)
	upgradeMenu.info.show()


func _on_info_mouse_exited():
	upgradeMenu.info.hide()


func _on_buy_pressed():
	var upgrade = Name
	var level = Global.upgrades[Name]
	var text = 'Do you want to upgrade ' + str(upgrade) + '\nto level ' + str(level + 1) + ' for ' + str(cost) + 'm?'
	
	upgradeMenu.upgradeNumber = Number
	upgradeMenu.buyLabel.text = text
	upgradeMenu.buyWindow.show()
	
func upgrade():
	Global.upgrades[Name] += 1
	Global.mossiesInStock -= cost
	currentLevel = Global.upgrades[Name]
	if currentLevel < maxLevel:
		cost = int(UpgradeText.upgradeCost[currentLevel + 1])
		upgradeCost.text = 'Cost ' + str(cost) + 'm'
	elif currentLevel >= maxLevel:
		cost = 'N/A'
		upgradeCost.text = 'Maxed'
		upgradeCost.disabled = true
	upgradeMenu.mossyLabel.text = 'Mosquitos: ' + str(Global.mossiesInStock)
	upgradeLevel.text = str(currentLevel) + '/' + str(maxLevel)
	
