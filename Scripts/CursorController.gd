extends Node

@onready var waveController = get_parent().waveController
@onready var bossWave : bool = false
@onready var isOnBoss: bool = false

var mainCursor = load("res://Assets/UI/Cursors/CurrentCursors/AAA Finger Up.png")
var mainCursorClick = load("res://Assets/UI/Cursors/CurrentCursors/AAA Finger Down.png")
var crosshair = load("res://Assets/UI/Cursors/CurrentCursors/AAA Crosshair.png")

var mainCursorVector = Vector2(20,0)
var crosshairVector = Vector2(32,32)

func _ready():
	DefaultCursor()
	
	
func _process(delta):
	if !bossWave:
		if Input.is_action_pressed("Jump"):
			DefaultCursorClick()
		else:
			DefaultCursor()
#	else:
#		BossFightCursor()
	

#	if Input.is_action_just_pressed("Jump"):
#		DefaultCursorClick()
#		await(get_tree().create_timer(.1).timeout)
#		DefaultCursor()
	
func SetBossWave(x):
	if x:
		bossWave = true
	else:
		bossWave = false
		
		
func DefaultCursor():
	Input.set_custom_mouse_cursor(mainCursor,0,mainCursorVector)
	
func DefaultCursorClick():
	Input.set_custom_mouse_cursor(mainCursorClick,0,mainCursorVector)
	
	
func BossFightCursor():
	Input.set_custom_mouse_cursor(crosshair,0,crosshairVector)


func _on_area_2d_mouse_entered():
	if bossWave:
		BossFightCursor()


func _on_area_2d_mouse_exited():
	if bossWave:
		DefaultCursor()
