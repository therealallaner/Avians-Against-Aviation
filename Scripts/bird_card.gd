extends Control

@onready var options = $PanelContainer/MarginContainer/PanelContainer2/MarginContainer/PanelContainer3/MarginContainer/VBoxContainer/OptionButton
@onready var spriteContainer = $PanelContainer/MarginContainer/PanelContainer2/MarginContainer/PanelContainer3/MarginContainer/VBoxContainer/SpriteContainer
@onready var mossiesLabel = $PanelContainer/MarginContainer/PanelContainer2/MarginContainer/PanelContainer3/MarginContainer/VBoxContainer/VBoxContainer/Label2
@onready var aviary = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()


@export var blackBird: PackedScene
@export var greenBird: PackedScene
@export var pinkBird: PackedScene
@export var redBird: PackedScene
@export var yellowBird: PackedScene

var test = "Test"

func _ready():
	mossiesLabel.text = str(Global.mossiesInStock1) + "/100"

func Change_Sprite(i):
	if i == 1:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = blackBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Check_Unlocked("blackBird1")
	elif i == 2:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = greenBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Check_Unlocked("greenBird1")
	elif i == 3:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = pinkBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Check_Unlocked("pinkBird1")
	elif i == 4:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = redBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Check_Unlocked("redBird1")
	elif i == 5:
		var pos:Vector2
		var children = spriteContainer.get_children()
		for c in children:
			pos = c.position
			c.queue_free()
		var instance = yellowBird.instantiate()
		spriteContainer.add_child(instance)
		instance.position = pos
		Check_Unlocked("yellowBird1")


func Check_Unlocked(s):
	if !Global.birdUnlocks1[s]:
		aviary.select1.text = "Buy"
	else:
		aviary.select1.text = "Select"
	Global.currentBird1 = s
	
	
func _on_option_button_item_selected(index):
	Change_Sprite(index)
