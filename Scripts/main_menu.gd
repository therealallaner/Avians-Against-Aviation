extends Control



@onready var parent = get_parent()
@onready var aviaryMenu = parent.get_node("Aviary")
@onready var optionsMenu = parent.get_node("Options")
@onready var options = $VBoxContainer/Options
@onready var aviary = $VBoxContainer/Aviary
@onready var stats = $VBoxContainer/HBoxContainer/Stats
@onready var quitMenu = $QuitMenu
@onready var start = $Start
@onready var showTimer = $Start/ShowTimer
@onready var hideTimer = $Start/HideTimer


func _ready():
	quitMenu.hide()
	hideTimer.start()
	
	
func _process(delta):
	if quitMenu.visible:
		Global.mouseHovering = true



func _on_quit_pressed():
	quitMenu.show()

func _on_yes_pressed():
	get_tree().quit()


func _on_no_pressed():
	quitMenu.hide()
	
	
func _on_aviary_pressed():
	parent.Menu_Open(parent.mainMenu,aviaryMenu)
	
	
func _on_options_pressed():
	parent.Menu_Open(parent.mainMenu,optionsMenu)



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


func _on_show_timer_timeout():
	start.show()
	hideTimer.start()


func _on_hide_timer_timeout():
	start.hide()
	showTimer.start()



