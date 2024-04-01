extends CharacterBody2D
class_name Player


@onready var blackBird1 = preload("res://Scenes/Players/Sprites/black_bird_1.tscn")
@onready var greenBird1 = preload("res://Scenes/Players/Sprites/green_bird_1.tscn")
@onready var yellowBird1 = preload("res://Scenes/Players/Sprites/yellow_bird_1.tscn")
@onready var pinkBird1 = preload("res://Scenes/Players/Sprites/pink_bird_1.tscn")
@onready var redBird1 = preload("res://Scenes/Players/Sprites/red_bird_1.tscn")

@onready var blackBird2 = preload("res://Scenes/Players/Sprites/black_bird_2.tscn")

@onready var blackBird3 = preload("res://Scenes/Players/Sprites/black_bird_3.tscn")

@onready var currentBird = blackBird1

@onready var bird1 = [blackBird1,greenBird1,yellowBird1,pinkBird1,redBird1]
@onready var bird2 = [blackBird2]
@onready var bird3 = []

var defaultPos = Vector2(384,540)


func _ready():
	Change_Bird(blackBird3)
	
	
func Change_Bird(bird):
	var instance = bird.instantiate()
	add_child(instance)
	self.global_position = defaultPos
	instance.Anim_Controller(instance.animPlayer)
