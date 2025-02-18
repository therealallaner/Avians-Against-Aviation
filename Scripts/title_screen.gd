extends Node2D


@onready var parent = get_parent()
@onready var avians = $Avians
@onready var against = $Against
@onready var aviation = $Aviation
@onready var timer = $Timer

var y = false
var z = false


func _ready():
	if Global.justOpened:
		Global.mouseHovering = true
		await(get_tree().create_timer(0.5).timeout)
		parent.Title_Screen(avians,y,z)
		await(get_tree().create_timer(0.5).timeout)
		parent.Title_Screen(against,y,z)
		await(get_tree().create_timer(0.5).timeout)
		parent.Title_Screen(aviation,y,z)
		await(get_tree().create_timer(1).timeout)
		parent.Title_Screen(avians,against,aviation,true)
		Global.mouseHovering = false
		Global.justOpened = false
	elif !Global.justOpened:
		get_parent().Main_Menu()
