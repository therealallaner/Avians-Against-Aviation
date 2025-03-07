extends Control

@export var cardNumber : int
@export var cardName : String
@export var sprite1 : PackedScene
@export var sprite2 : PackedScene
@export var sprite3 : PackedScene
@export var sprite4 : PackedScene
@export var sprite5 : PackedScene
@export var sprite6 : PackedScene
@export var sprite7 : PackedScene

@onready var birdName = $PanelContainer/VBoxContainer/PanelContainer/Name
@onready var carousel = $"Carousel"
@onready var rightButt = $"PanelContainer/VBoxContainer/HBoxContainer2/RIght Button"
@onready var leftButt = $"PanelContainer/VBoxContainer/HBoxContainer2/Left Button"
@onready var buyButt = $"PanelContainer/VBoxContainer/HBoxContainer2/Buy Button"
@onready var spacerLeft = $PanelContainer/VBoxContainer/HBoxContainer2/spacer
@onready var spacerRight = $PanelContainer/VBoxContainer/HBoxContainer2/spacer2

@onready var sprites = [
	sprite1,sprite2,sprite3,sprite4,sprite5,sprite6,sprite7
]



var birdNames = {
	1: 'blackBird',
	2: 'redBird',
	3: 'greenBird',
	4: 'pinkBird',
	5: 'yellowBird',
	6: 'blueBird',
	7: 'purpleBird'
}


var carouselOrient = {
	'default': Vector2(2880,550),
	0: Vector2(860,550),
	1: Vector2(960,550),
	2: Vector2(1060,550)
}

var carouselPos = 1
var transitionTime := 0.5

var vis = Color(1,1,1,1)
var inVis = Color(1,1,1,0)
var spacerDefault = Vector2(10,0)
var spacerExpand = Vector2(57,0)

func _ready():
	Compensate_for_Control()
	Default_Pos()
	birdName.text = cardName
	
	Check_Sprite_Number()

func Compensate_for_Control():
	
	if Global.demo:
		return
		
	if cardNumber == 1:
		carouselOrient['default'] = Vector2(2531,550)
		carouselOrient[0] = Vector2(511,550)
		carouselOrient[1] = Vector2(611,550)
		carouselOrient[2] = Vector2(711,550)
	
	elif cardNumber == 3:
		carouselOrient["default"] = Vector2(3229,550)
		carouselOrient[0] = Vector2(1209,550)
		carouselOrient[1] = Vector2(1309,550)
		carouselOrient[2] = Vector2(1409,550)
		

func Check_Sprite_Number():
	if cardNumber == 1:
		sprites.pop_back()
		sprites.pop_back()
	

func Default_Pos():
	var currentBird = sprite1
	var i1
	for bird in birdNames:
		var b = (str(birdNames[bird]) + str(cardNumber))
		if b == Global.currentBird:
			currentBird = sprites[bird - 1]
			carouselPos = bird
			buyButt.text = 'Selected'
			
	if carouselPos > 1:
		leftButt.show()
		spacerLeft.set_custom_minimum_size(spacerDefault)
	else:
		leftButt.hide()
		spacerLeft.set_custom_minimum_size(spacerExpand)
	
	i1 = currentBird.instantiate()
	carousel.add_child(i1)
	i1.position = carouselOrient['default']

	
	
func Carousel_Movement_R():
	
	var s1 = carousel.get_children()[0]
	
	var s2 = sprites[carouselPos].instantiate()
	carousel.add_child(s2)
	s2.position = carouselOrient[2]
	s2.set_self_modulate(Color(1,1,1,0.5))
	
	var tween = create_tween()
	tween.parallel().tween_property(s1, "position", carouselOrient[0], transitionTime)
	tween.parallel().tween_property(s1, "self_modulate", inVis, transitionTime)
	tween.parallel().tween_property(s2, "position", carouselOrient[1], transitionTime)
	tween.parallel().tween_property(s2, "self_modulate", vis, transitionTime)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	
	carouselPos += 1
	
	await(get_tree().create_timer(transitionTime).timeout)
	carousel.get_children()[0].queue_free()
#
func Carousel_Movement_L():
	var s1 = carousel.get_children()[0]
	
	var s2 = sprites[carouselPos - 2].instantiate()
	carousel.add_child(s2)
	s2.position = carouselOrient[0]
	s2.set_self_modulate(Color(1,1,1,0.5))
	
	var tween = create_tween()
	tween.parallel().tween_property(s1, "position", carouselOrient[2], transitionTime)
	tween.parallel().tween_property(s1, "self_modulate", inVis, transitionTime)
	tween.parallel().tween_property(s2, "position", carouselOrient[1], transitionTime)
	tween.parallel().tween_property(s2, "self_modulate", vis, transitionTime)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	
	carouselPos -= 1
	
	await(get_tree().create_timer(transitionTime).timeout)
	carousel.get_children()[0].queue_free()

func Check_If_Owned():
	var currentBird = str(birdNames[carouselPos]) + str(cardNumber)
	
	if cardNumber == 1:
		if Global.birdUnlocks1[currentBird]:
			buyButt.text = 'Select'
			if currentBird == Global.currentBird:
				buyButt.text = 'Selected'
		else:
			buyButt.text = 'Cost 100'
			
	elif cardNumber == 2:
		if Global.birdUnlocks2[currentBird]:
			buyButt.text = 'Select'
			if currentBird == Global.currentBird:
				buyButt.text = 'Selected'
		else:
			buyButt.text = 'Cost 250'
			
	elif cardNumber == 3:
		if Global.birdUnlocks3[currentBird]:
			buyButt.text = 'Select'
			if currentBird == Global.currentBird:
				buyButt.text = 'Selected'
		else:
			buyButt.text = 'Cost 675'
			

func _on_r_ight_button_pressed():
	Carousel_Movement_R()
	Check_If_Owned()
	
	if !leftButt.visible:
		leftButt.show()
		spacerLeft.set_custom_minimum_size(spacerDefault)
	
	if carouselPos == len(sprites):
		rightButt.hide()
		spacerRight.set_custom_minimum_size(spacerExpand)
	
	rightButt.disabled = true
	await(get_tree().create_timer(transitionTime).timeout)
	rightButt.disabled = false
	

func _on_left_button_pressed():
	Carousel_Movement_L()
	Check_If_Owned()
	
	if !rightButt.visible:
		rightButt.show()
		spacerRight.set_custom_minimum_size(spacerDefault)
	
	
	if carouselPos == 1:
		leftButt.hide()
		spacerLeft.set_custom_minimum_size(spacerExpand)
		
		
	leftButt.disabled = true
	await(get_tree().create_timer(transitionTime).timeout)
	leftButt.disabled = false
