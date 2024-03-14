extends Node

@onready var jetPlane = preload("res://Scenes/Planes/jet_plane.tscn")

var spawns = []

func _ready():
	for s in get_children():
		spawns.append(s)



func Plane_Spawn():
	var slot = Global.Random_List(spawns)
	for s in spawns:
		if s != slot:
			var instance = jetPlane.instantiate()
			add_child(instance)
			instance.position = s.position
			instance.target.x = (s.position.x - 500)
			instance.target.y = s.position.y
			instance.waitTimer.wait_time = randf_range(.9,1.1)
