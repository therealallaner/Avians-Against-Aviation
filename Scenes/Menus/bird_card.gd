extends Control

@export var sprite1 : PackedScene
@export var sprite2 : PackedScene
@export var sprite3 : PackedScene
@export var sprite4 : PackedScene
@export var sprite5 : PackedScene
@export var sprite6 : PackedScene
@export var sprite7 : PackedScene


@onready var sprites = [
	sprite1,sprite2,sprite3,sprite4,sprite5,sprite6,sprite7
]

var carouselPos = {
	0: Vector2(860,540),
	1: Vector2(960,540),
	2: Vector2(1060,540)
}

var carouselOrder = []

func _ready():
	Default_Pos()




func Default_Pos():
	
	var i1 = sprite1.instantiate()
	add_child(i1)
	i1.position = carouselPos[1]
	carouselOrder.append(sprite1)
	
	var i2 = sprite2.instantiate()
	add_child(i2)
	i2.position = carouselPos[2]
	i2.set_self_modulate(Color(1,1,1,0))
	carouselOrder.append(sprite2)
	
	
func Carousel_Movement():
	pass
	
