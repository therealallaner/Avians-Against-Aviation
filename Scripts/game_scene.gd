extends Node2D

@onready var mainMenu = $Menus/MainMenu
@onready var test = preload("res://Scenes/Planes/prop_planes.tscn")

func _on_timer_timeout():
	var instance = test.instantiate()
	add_child(instance)
	instance.position = Vector2(randf_range(2000,2100),randf_range(50,1000))
