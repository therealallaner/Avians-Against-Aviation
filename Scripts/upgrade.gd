extends Control


@export var Icon : Texture2D
@export var Name : String
@export var Info : String

@onready var upgradeName = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/Name
@onready var upgradeIcon = $PanelContainer/VBoxContainer/PanelContainer3/HBoxContainer2/Icon

func _ready():
	upgradeName.text = Name
	upgradeIcon.texture = Icon
