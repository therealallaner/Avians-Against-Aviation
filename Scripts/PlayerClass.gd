extends CharacterBody2D
class_name Player


@onready var blackBird1 = preload("res://Scenes/Players/Sprites/black_bird_1.tscn")
@onready var greenBird1 = preload("res://Scenes/Players/Sprites/green_bird_1.tscn")
@onready var yellowBird1 = preload("res://Scenes/Players/Sprites/yellow_bird_1.tscn")
@onready var pinkBird1 = preload("res://Scenes/Players/Sprites/pink_bird_1.tscn")
@onready var redBird1 = preload("res://Scenes/Players/Sprites/red_bird_1.tscn")

@onready var blackBird2 = preload("res://Scenes/Players/Sprites/black_bird_2.tscn")
@onready var greenBird2
@onready var yellowBird2
@onready var pinkBird2
@onready var redBird2
@onready var blueBird2
@onready var purpleBird2

@onready var blackBird3 = preload("res://Scenes/Players/Sprites/black_bird_3.tscn")
@onready var greenBird3
@onready var yellowBird3
@onready var pinkBird3
@onready var redBird3
@onready var blueBird3
@onready var purpleBird3

@onready var currentBird = redBird1

@onready var bird1 = [blackBird1,greenBird1,yellowBird1,pinkBird1,redBird1]
@onready var bird2 = [blackBird2,greenBird2,yellowBird2,pinkBird2,redBird2,blueBird2,purpleBird2]
@onready var bird3 = [blackBird3,greenBird3,yellowBird3,pinkBird3,redBird3,blueBird3,purpleBird3]

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
	if Global.currentBird:
		print(Global.currentBird)
		currentBird = birddict[Global.currentBird]
	else:
		currentBird = birddict["blackBird1"]
		
	Change_Bird(currentBird)
	for c in get_children():
		if c.is_in_group("Bird"):
			visibility = c.visibility
	
	
	
func Change_Bird(bird):
	for c in get_children():
		if c.is_in_group("Bird"):
			c.queue_free()
	var instance = bird.instantiate()
	add_child(instance)
	self.global_position = defaultPos
	instance.Anim_Controller(instance.animPlayer)
	visibility = instance.visibility
