extends Control

@onready var options = $VBoxContainer/Options
@onready var birds = $VBoxContainer/Birds
@onready var stats = $VBoxContainer/HBoxContainer/Stats
@onready var quitMenu = $QuitMenu


func _ready():
	quitMenu.hide()
	
	
func _process(delta):
	if quitMenu.visible:
		Global.mouseHovering = true





func _on_quit_pressed():
	quitMenu.show()

func _on_yes_pressed():
	get_tree().quit()


func _on_no_pressed():
	quitMenu.hide()


func _on_options_mouse_entered():
	Global.mouseHovering = true


func _on_options_mouse_exited():
	Global.mouseHovering = false


func _on_birds_mouse_entered():
	Global.mouseHovering = true


func _on_birds_mouse_exited():
	Global.mouseHovering = false


func _on_stats_mouse_entered():
	Global.mouseHovering = true


func _on_stats_mouse_exited():
	Global.mouseHovering = false


func _on_quit_mouse_entered():
	Global.mouseHovering = true


func _on_quit_mouse_exited():
	Global.mouseHovering = false
