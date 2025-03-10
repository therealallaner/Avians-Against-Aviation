extends Node2D

@onready var menu = $Menus
@onready var mainMenu = $Menus/MainMenu
@onready var waveController = $WaveController
@onready var player = $HappyBird
@onready var gameOver = $Menus/GameOver
@onready var saver = $Saver
@onready var GUI = $Menus/GUI
@onready var wave = $WaveController.wave

var test = "Test"

var score = 0
var scoreMultiplier = 1
var mossies = 0


func _ready():
	Engine.time_scale = 1
	gameOver.hide()
