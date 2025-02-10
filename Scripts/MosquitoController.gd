extends Node

@onready var blackMossy1 = preload("res://Scenes/Mosquitos/black_mosquito_1.tscn")
@onready var blackMossy2 = preload("res://Scenes/Mosquitos/black_mosquito_2.tscn")
@onready var blackMossy3 = preload("res://Scenes/Mosquitos/black_mosquito_3.tscn")
@onready var redMossy = preload("res://Scenes/Mosquitos/red_mosquito_1.tscn")
@onready var purpleMossy = preload("res://Scenes/Mosquitos/purple_mosquito.tscn")
@onready var purpleMossy2 = preload("res://Scenes/Mosquitos/purple_mosquito_2.tscn")
@onready var shapes = $Shapes

@onready var blackMossies = [blackMossy1, blackMossy2]
@onready var redMossies = [redMossy]

@onready var mossyColors = [
	blackMossy1, 
	blackMossy2, 
	blackMossy3, 
	redMossy,
	purpleMossy,
	purpleMossy2
	]


func Spawn_Mossies():
	var shape = Global.Random_List(shapes.get_children())
	print(shape)
	#var list = Global.Random_List(mossyColors)
	var yPos = randf_range(100,1000)
	for p in shape.get_children():
		var instance = Global.Random_List(mossyColors).instantiate()
		add_child(instance)
		instance.position.x = p.position.x + 2000
		instance.position.y = p.position.y + yPos
		
		
