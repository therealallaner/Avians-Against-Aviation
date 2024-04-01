extends Node2D

@onready var mainMenu = $Menus/MainMenu
@onready var test = preload("res://Scenes/Planes/prop_planes.tscn")
@onready var waveController = $WaveController
@onready var player = $HappyBird
@onready var gameOver = $Menus/GameOver

var score = 0
var scoreMultiplier = 1
var bird1Mossies = 0
var bird2Mossies = 0
var bird3Mossies = 0


func _ready():
	Engine.time_scale = 1
	gameOver.hide()
