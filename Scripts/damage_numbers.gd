extends Node

@onready var label = $Label

var speed = 100
var red = Color(1,0,0,1)
var green = Color(0,1,0,1)
var blue = Color(0,1,1,1)

func _ready():
	pass
	

func Damage_Text(x,dmgType):
	label.text = str(x)
	
	if dmgType == 1:
		label.add_theme_color_override("font_color",red)
	elif dmgType == 2:
		label.add_theme_color_override("font_color",green)
	elif dmgType == 3:
		label.add_theme_color_override("font_color",blue)
		
	
	var newPos = Vector2(label.position.x + 50, label.position.y - 50)
	var tween = create_tween()
	tween.parallel().tween_property(label, "position", newPos, 1)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	await(get_tree().create_timer(1).timeout)
	queue_free()
