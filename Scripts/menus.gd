extends CanvasLayer

@onready var score = $Score
@onready var mainMenu = $MainMenu
@onready var gameOver = $GameOver
@onready var aviary = $Aviary
@onready var options = $Options
@onready var GUI = $GUI
@onready var stats = $Stats

@onready var whoosh1 = preload("res://Assets/SFX/Whooshes/Whoosh 1.mp3")
@onready var whoosh2 = preload("res://Assets/SFX/Whooshes/Whoosh 2.mp3")
@onready var whoosh3 = preload("res://Assets/SFX/Whooshes/Whoosh 3.mp3")
@onready var whoosh4 = preload("res://Assets/SFX/Whooshes/Whoosh 4.mp3")
@onready var whoosh5 = preload("res://Assets/SFX/Whooshes/Whoosh 5.mp3")
@onready var whoosh6 = preload("res://Assets/SFX/Whooshes/Whoosh 6.mp3")
@onready var whoosh7 = preload("res://Assets/SFX/Whooshes/Whoosh 7.mp3")
@onready var whoosh8 = preload("res://Assets/SFX/Whooshes/Whoosh 8.mp3")
@onready var whoosh9 = preload("res://Assets/SFX/Whooshes/Whoosh 9.mp3")

@onready var lightWhooshes = [whoosh1,whoosh2,whoosh3,whoosh4]
@onready var heavyWhooshes = [whoosh5,whoosh6,whoosh7,whoosh8,whoosh9]

var isInMenu = false
var menuTransitionTime := 0.25


func _ready():
	gameOver.hide()


func Menu_Open(menu1,menu2):
	var tween = create_tween()
	tween.parallel().tween_property(menu1, "position", Vector2(-1920,0), menuTransitionTime)
	tween.parallel().tween_property(menu2, "position", Vector2(0,0), menuTransitionTime)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	var rando = Global.Random_List(lightWhooshes)
	$AudioStreamPlayer.stream = rando
	$AudioStreamPlayer.play()
	
	
func Menu_Close(menu1,menu2):
	var tween = create_tween()
	tween.parallel().tween_property(menu1, "position", Vector2(1920,0), menuTransitionTime)
	tween.parallel().tween_property(menu2, "position", Vector2(0,0), menuTransitionTime)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
#	var tween = create_tween()
#	tween.tween_property(hBox, "offset_right", -hBox.offset_right, menu_open_time)
#	tween.set_ease(Tween.EASE_IN_OUT)
#	tween.play()
	var rando = Global.Random_List(lightWhooshes)
	$AudioStreamPlayer.stream = rando
	$AudioStreamPlayer.play()


func Title_Screen(x,y,z,a=false):
	if !a:
		var tween = create_tween()
		tween.parallel().tween_property(x, "position", Vector2(0,0), menuTransitionTime)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.play()
		var rando = Global.Random_List(heavyWhooshes)
		$AudioStreamPlayer.stream = rando
		$AudioStreamPlayer.play()
	else:
		var tween = create_tween()
		tween.parallel().tween_property(x, "position", Vector2(0,-1080), menuTransitionTime)
		tween.parallel().tween_property(y, "position", Vector2(0,-1080), menuTransitionTime)
		tween.parallel().tween_property(z, "position", Vector2(0,-1080), menuTransitionTime)
		#tween.parallel().tween_property(mainMenu, "position", Vector2(0,0), menuTransitionTime)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.play()
		var rando = Global.Random_List(heavyWhooshes)
		$AudioStreamPlayer.stream = rando
		$AudioStreamPlayer.play()
		await(get_tree().create_timer(.1).timeout)
		mainMenu.show()
		mainMenu.showTimer.start()
		
		
func Main_Menu():
	$MainMenu.show()
	$MainMenu.showTimer.start()
	
	
func Game_Start_Anim():
	var tween = create_tween()
	tween.parallel().tween_property(score, "position", Vector2(0,0), menuTransitionTime)
	tween.parallel().tween_property(GUI, "position", Vector2(0,0), menuTransitionTime)
	
