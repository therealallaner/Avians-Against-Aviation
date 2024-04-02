extends CanvasLayer

@onready var score = $Score
@onready var mainMenu = $MainMenu
@onready var gameOver = $GameOver
@onready var aviary = $Aviary

var isInMenu = false
var menuTransitionTime := 0.25


func _ready():
	score.show()
	mainMenu.show()
	gameOver.hide()


func Menu_Open(menu1,menu2):
	var tween = create_tween()
	tween.parallel().tween_property(menu1, "position", Vector2(-1920,0), menuTransitionTime)
	tween.parallel().tween_property(menu2, "position", Vector2(0,0), menuTransitionTime)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	
	
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
