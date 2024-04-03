extends Control

@onready var options = $PanelContainer/MarginContainer/PanelContainer2/MarginContainer/PanelContainer3/MarginContainer/VBoxContainer/OptionButton
@onready var spriteContainer = $PanelContainer/MarginContainer/PanelContainer2/MarginContainer/PanelContainer3/MarginContainer/VBoxContainer/SpriteContainer
@onready var mossiesLabel = $PanelContainer/MarginContainer/PanelContainer2/MarginContainer/PanelContainer3/MarginContainer/VBoxContainer/VBoxContainer/Label2
@onready var aviary = get_parent().get_parent().get_parent().get_parent().get_parent()


@export var blackBird: PackedScene
@export var greenBird: PackedScene
@export var pinkBird: PackedScene
@export var redBird: PackedScene
@export var yellowBird: PackedScene
@export var blueBird: PackedScene
@export var purpleBird: PackedScene

var test = "Test"

func _ready():
	mossiesLabel.text = str(Global.mossiesInStock2) + "/100"

func Change_Sprite(i):
	print(i)
	if i == 1:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = blackBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "blackBird2"
	elif i == 2:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = greenBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "greenBird2"
	elif i == 3:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = pinkBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "pinkBird2"
	elif i == 4:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = redBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "redBird2"
	elif i == 5:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = yellowBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "yellowBird2"
	elif i == 6:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = blueBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "blueBird2"
	elif i == 7:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = purpleBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Global.currentBird2 = "purpleBird2"


func _on_option_button_item_selected(index):
	Change_Sprite(index)
