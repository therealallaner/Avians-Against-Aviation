extends Control

@onready var stats = $PanelContainer/MarginContainer/ScrollContainer/Stats
@onready var statLine = preload("res://Scenes/Menus/stat_line.tscn")
@onready var backButt = $PanelContainer/MarginContainer/ScrollContainer/Stats/Back
@onready var spacer = $PanelContainer/MarginContainer/ScrollContainer/Stats/Spacer

func _ready():
	for s in Global.playerStats:
		var instance = statLine.instantiate()
		stats.add_child(instance)
		instance.statName.text = s
		#if s == "Crit Chance":
			#pass
			#instance.statNumber.text = str(snapped(Global.playerStats[s],.01))
			#print(s," ",Global.playerStats[s])
		#else:
		instance.statNumber.text = str(Global.playerStats[s])
	stats.move_child(spacer,-1)
	stats.move_child(backButt,-1)


func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true

func _on_back_pressed():
	get_parent().Menu_Close(get_parent().stats,get_parent().mainMenu)
	await(get_tree().create_timer(.1).timeout)
	Global.mouseHovering = false
