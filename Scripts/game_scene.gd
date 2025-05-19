extends Node2D

@onready var menu = $Menus
@onready var mainMenu = $Menus/MainMenu
@onready var waveController = $WaveController
@onready var player = $HappyBird
@onready var gameOver = $Menus/GameOver
@onready var saver = $Saver
@onready var GUI = $Menus/GUI
@onready var wave = $WaveController.wave
@onready var cursorController = $CursorController
@onready var tipController = $TipController
@onready var camera = $CameraShake


var test = "Test"

var score = 0
var mossies = 0


func _ready():
	Engine.time_scale = 1
	gameOver.hide()
	
