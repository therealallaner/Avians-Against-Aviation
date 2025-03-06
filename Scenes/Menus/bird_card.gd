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

var carouselPrimary = ''

var transitionTime := 0.25

func _ready():
	Default_Pos()
	await(get_tree().create_timer(3).timeout)
	Carousel_Movement_R()
	await(get_tree().create_timer(3).timeout)
	Carousel_Movement_R()
	await(get_tree().create_timer(3).timeout)
	Carousel_Movement_R()



func Default_Pos():
	
	var i1 = sprite1.instantiate()
	add_child(i1)
	i1.position = carouselPos[1]
	carouselPrimary = i1
	
	
func Carousel_Movement_R():
	var s1 = carouselPrimary
	#print(s1)
	
	var s1ArrayPos = sprites.bsearch(s1)
	#print(s1ArrayPos)
	
	var s2 = sprites[s1ArrayPos + 1].instantiate()
	add_child(s2)
	s2.position = carouselPos[2]
	#print(s2)
	
	var tween = create_tween()
	tween.parallel().tween_property(s1, "position", Vector2(860,540), transitionTime)
	tween.parallel().tween_property(s1, "self_modulate", Color(1,1,1,0), transitionTime)
	tween.parallel().tween_property(s2, "position", Vector2(960,540), transitionTime)
	tween.parallel().tween_property(s2, "set_self_modulate", Color(1,1,1,1), transitionTime)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	
	print(get_children())
	carouselPrimary = s2
	
