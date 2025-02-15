extends CharacterBody2D
class_name Player


@onready var blackBird1 = preload("res://Scenes/Players/Sprites/black_bird_1.tscn")
@onready var greenBird1 = preload("res://Scenes/Players/Sprites/green_bird_1.tscn")
@onready var yellowBird1 = preload("res://Scenes/Players/Sprites/yellow_bird_1.tscn")
@onready var pinkBird1 = preload("res://Scenes/Players/Sprites/pink_bird_1.tscn")
@onready var redBird1 = preload("res://Scenes/Players/Sprites/red_bird_1.tscn")

@onready var blackBird2 = preload("res://Scenes/Players/Sprites/black_bird_2.tscn")
@onready var greenBird2 = preload("res://Scenes/Players/Sprites/green_bird_2.tscn")
@onready var yellowBird2 = preload("res://Scenes/Players/Sprites/yellow_bird_2.tscn")
@onready var pinkBird2 = preload("res://Scenes/Players/Sprites/pink_bird_2.tscn")
@onready var redBird2 = preload("res://Scenes/Players/Sprites/red_bird_2.tscn")
@onready var blueBird2 = preload("res://Scenes/Players/Sprites/blue_bird_2.tscn")
@onready var purpleBird2 = preload("res://Scenes/Players/Sprites/purple_bird_2.tscn")

@onready var blackBird3 = preload("res://Scenes/Players/Sprites/black_bird_3.tscn")
@onready var greenBird3 = preload("res://Scenes/Players/Sprites/green_bird_3.tscn")
@onready var yellowBird3 = preload("res://Scenes/Players/Sprites/yellow_bird_3.tscn")
@onready var pinkBird3 = preload("res://Scenes/Players/Sprites/pink_bird_3.tscn")
@onready var redBird3 = preload("res://Scenes/Players/Sprites/red_bird_3.tscn")
@onready var blueBird3 = preload("res://Scenes/Players/Sprites/blue_bird_3.tscn")
@onready var purpleBird3 = preload("res://Scenes/Players/Sprites/purple_bird_3.tscn")

@onready var currentBird = redBird1

@onready var bird1 = [blackBird1,greenBird1,yellowBird1,pinkBird1,redBird1]
@onready var bird2 = [blackBird2,greenBird2,yellowBird2,pinkBird2,redBird2,blueBird2,purpleBird2]
@onready var bird3 = [blackBird3,greenBird3,yellowBird3,pinkBird3,redBird3,blueBird3,purpleBird3]

@onready var sounds1 = preload("res://Scenes/Players/Bird SFX Scenes/bird1_sounds.tscn")
@onready var sounds2 = preload("res://Scenes/Players/Bird SFX Scenes/bird2_sounds.tscn")
@onready var sounds3 = preload("res://Scenes/Players/Bird SFX Scenes/bird3_sounds.tscn")


@onready var birddict = {
	"blackBird1": blackBird1,
	"greenBird1": greenBird1,
	"yellowBird1": yellowBird1,
	"pinkBird1": pinkBird1,
	"redBird1": redBird1,
	
	"blackBird2": blackBird2,
	"greenBird2": greenBird2,
	"yellowBird2": yellowBird2,
	"pinkBird2": pinkBird2,
	"redBird2": redBird2,
	"blueBird2": blueBird2,
	"purpleBird2": purpleBird2,
	
	"blackBird3": blackBird3,
	"greenBird3": greenBird3,
	"yellowBird3": yellowBird3,
	"pinkBird3": pinkBird3,
	"redBird3": redBird3,
	"blueBird3": blueBird3,
	"purpleBird3": purpleBird3,
}

@onready var visibility: VisibleOnScreenNotifier2D

var defaultPos = Vector2(384,540)



func _ready():
	Check_Global()
		
	Change_Bird(currentBird)
	
	for c in get_children():
		if c.is_in_group("Bird"):
			visibility = c.visibility
	
	
func Check_Global():
	if Global.currentBird:
		currentBird = birddict[Global.currentBird]
	else:
		currentBird = birddict["blackBird1"]
	
func Change_Bird(bird):
	for c in get_children():
		if c.is_in_group("Bird"):
			c.queue_free()
	var instance = bird.instantiate()
	add_child(instance)
	self.global_position = defaultPos
	instance.Anim_Controller(instance.animPlayer)
	visibility = instance.visibility
	Check_Global()
	Bird_Sounds()

func Bird_Sounds():
	for c in get_children():
		if c.is_in_group("SFX"):
			c.timer.stop()
			c.queue_free()
			
	for c in get_children():
		if c.is_in_group("Bird1"):
			add_child(sounds1.instantiate())
		if c.is_in_group("Bird2"):
			add_child(sounds2.instantiate())
		if c.is_in_group("Bird3"):
			add_child(sounds3.instantiate())
			
	for c in get_children():
		if c.is_in_group("SFX"):
			c.timer.start()
