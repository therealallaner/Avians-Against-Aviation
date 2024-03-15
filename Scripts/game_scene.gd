extends Node2D

@onready var mainMenu = $Menus/MainMenu
@onready var test = preload("res://Scenes/Planes/prop_planes.tscn")
@onready var waveController = $WaveController
@onready var gameOver = $Menus/GameOver

var score = 0
var scoreMultiplier = 1
var mossiesEaten = 0


func _ready():
	Engine.time_scale = 1
	gameOver.hide()
