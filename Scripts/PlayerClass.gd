extends CharacterBody2D
class_name Player


@onready var tropicalParrot = preload("res://Scenes/Players/Sprites/tropical_parrot.tscn")
@onready var greenParrot = preload("res://Scenes/Players/Sprites/green_parrot.tscn")

@onready var currentBird = tropicalParrot

var defaultPos = Vector2(384,540)


func _ready():
	Change_Bird(tropicalParrot)
	
	
func Change_Bird(bird):
	var instance = bird.instantiate()
	add_child(instance)
	self.global_position = defaultPos
	instance.Anim_Controller(instance.animPlayer)
