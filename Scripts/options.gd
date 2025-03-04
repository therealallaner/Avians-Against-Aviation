extends Control

@onready var master = $VBoxContainer/VBoxContainer2/Master
@onready var music = $VBoxContainer/VBoxContainer/Music
@onready var sfx = $VBoxContainer/VBoxContainer3/SFX

func _ready():
	master.value = Global.masterVolume
	music.value = Global.musicVolume
	sfx.value = Global.sfxVolume
	
func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true

func _on_back_pressed():
	get_parent().Menu_Close(get_parent().options,get_parent().mainMenu)
	await(get_tree().create_timer(.1).timeout)
	Global.mouseHovering = false
	Global.Save_Game()
