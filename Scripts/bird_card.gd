extends Control


@export var birdColor: String

@onready var color = $VBoxContainer/Button
@onready var label = $VBoxContainer/Label
@onready var progress = $VBoxContainer/ProgressBar


func _ready():
	color.text = birdColor
