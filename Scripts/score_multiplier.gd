extends Sprite2D

@onready var timer = $Timer
@onready var juiceTimer = $JuiceTimer
@onready var juice = preload("res://Scenes/Main/juice.tscn")

var upgradeNumber = 1

var xSpeed = randf_range(300,400)
var ySpeed = Random_Y_Speed()

var upperLimit = 150
var lowerLimit = 930


func _process(delta):
	position.y += ySpeed * delta
	position.x += -xSpeed * delta
	
	if position.x < -20:
		queue_free()
	
	if position.y < upperLimit:
		ySpeed = randf_range(200,400)
		timer.wait_time = 2
		timer.stop()
		timer.start()
		
	if position.y > lowerLimit:
		ySpeed = randf_range(-200,-400)
		timer.wait_time = 2
		timer.stop()
		timer.start()

func Random_Y_Speed():
	return Global.Random_List([randf_range(-200,-400),randf_range(200,400)])

func _on_timer_timeout():
	timer.wait_time = randf_range(.25,3.0)
	var ySpeedNew = Random_Y_Speed()
	var tween = create_tween()
	tween.parallel().tween_property(self, "ySpeed", ySpeedNew, .75)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()


func _on_juice_timer_timeout():
	var instance = juice.instantiate()
	get_parent().add_child(instance)
	instance.position = self.position
