extends Node


@onready var propPlane = preload("res://Scenes/Planes/prop_planes.tscn")
@onready var timer = $Timer
@onready var wave = get_parent().wave

var difficulty = 0


func Spawn_Props(d):
	difficulty = d
	timer.start()
	
func Stop_Props():
	timer.stop()
	get_parent().waveTimer.start()


func Plane_Spawn():
	var instance = propPlane.instantiate()
	add_child(instance)
	instance.position = Vector2(2000,randf_range(50,1030))
	if wave > 10:
		instance.xSpeed = randf_range(300,450)
	elif wave > 20:
		instance.xSpeed = randf_range(400,600)

func _on_timer_timeout():
	wave = get_parent().wave
	if difficulty > 0:
		difficulty -= 1
		Plane_Spawn()
		if randf() < .5:
			Plane_Spawn()
			if randf() < .2:
				Plane_Spawn()
			
	else:
		Stop_Props()
		difficulty = 0

	if wave <= 3:
		timer.wait_time = randf_range(1.0,2.0)
	elif wave <=6:
		timer.wait_time = randf_range(1.0,1.75)
	elif wave <=12:
		timer.wait_time = randf_range(.5,1.5)
	elif wave <= 18:
		timer.wait_time = randf_range(.5,1.25)
	elif wave <= 28:
		timer.wait_time = randf_range(.5,1.0)
	elif wave <= 41:
		timer.wait_time = randf_range(.5,.75)
	else:
		timer.wait_time = randf_range(.3,.6)
