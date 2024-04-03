extends Control

@onready var master = $VBoxContainer/VBoxContainer2/Master
@onready var music = $VBoxContainer/VBoxContainer/Music

func _ready():
	master.value = Global.masterVolume
	music.value = Global.musicVolume
	
	
func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true

func _on_back_pressed():
	get_parent().Menu_Close(get_parent().options,get_parent().mainMenu)
