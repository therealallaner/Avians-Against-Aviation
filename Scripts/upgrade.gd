extends Control


@export var Icon : Texture2D
@export var Name : String

@onready var upgradeMenu = get_parent().get_parent().get_parent()
@onready var upgradeName = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Name
@onready var upgradeIcon = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/Icon
@onready var upgradeLevel = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/VBoxContainer/Level
@onready var upgradeCost = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/VBoxContainer/Buy



func _ready():
	upgradeName.text = Name
	upgradeIcon.texture = Icon
	if Name == 'Coming Soon':
		upgradeLevel.text = 'N/A'
	else:
		upgradeLevel.text = str(Global.upgrades[Name]) + '/20'
	
	#$Wave.text = 'Wave: ' + str(x)


func _on_info_mouse_entered():
	upgradeMenu.infoLabel.text = UpgradeText.upgradeText[Name]
	upgradeMenu.info.show()


func _on_info_mouse_exited():
	upgradeMenu.info.hide()
