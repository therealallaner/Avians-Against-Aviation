extends Node2D

@onready var mainMenu = $Menus/MainMenu
@onready var test = preload("res://Scenes/Planes/prop_planes.tscn")
@onready var waveController = $WaveController

var score = 0
var scoreMultiplier = 1

