extends CharacterBody2D
class_name Player


@onready var blackBird1 = preload("res://Scenes/Players/Sprites/black_bird_1.tscn")
@onready var greenBird1 = preload("res://Scenes/Players/Sprites/green_bird_1.tscn")

@onready var currentBird = blackBird1

var defaultPos = Vector2(384,540)


func _ready():
	Change_Bird(greenBird1)
	
	
func Change_Bird(bird):
	var instance = bird.instantiate()
	add_child(instance)
	self.global_position = defaultPos
	instance.Anim_Controller(instance.animPlayer)
