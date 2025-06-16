extends Sprite2D

@onready var sound1 = preload("res://Assets/SFX/Torpedo Sounds/ES_Rocket, Launch, Pass By, Fast 01 - Epidemic Sound - 0235-1743.wav")
@onready var sound2 = preload("res://Assets/SFX/Torpedo Sounds/ES_Rocket, Launch, Pass By, Fast 01 - Epidemic Sound - 3112-4506.wav")
@onready var sound3 = preload("res://Assets/SFX/Torpedo Sounds/ES_Rocket, Launch, Pass By, Fast 01 - Epidemic Sound - 5661-7441.wav")


@onready var sounds = [sound1, sound2, sound3]

var flySpeed = 1
var damage = 40


func _ready():
	$AnimatedSprite2D.play("flame")


func _process(delta):
	position.x -= flySpeed
	position.y = position.y

func _on_timer_timeout():
	if flySpeed < 600:
		flySpeed *= 2.5
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	$Timer.stop()
	flySpeed = 0
	await(get_tree().create_timer(2).timeout)
	queue_free()


func _on_timer_2_timeout():
	if !$AudioStreamPlayer2D.stream:
		$AudioStreamPlayer2D.stream = Global.Random_List(sounds)
		$AudioStreamPlayer2D.play()
