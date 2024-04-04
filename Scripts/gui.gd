extends Control

@onready var gameScene = get_parent().get_parent()
@onready var playerHP = $PlayerHP
@onready var bossHP = $BossHP


func _ready():
	bossHP.hide()
	
	
func _process(delta):
	Update_Player_HP()


func Update_Player_HP():
	var playerHPCurr = gameScene.player.HP
	playerHP.value = playerHPCurr

func Update_Boss_HP(hp):
	var bossHPCurr = hp
	bossHP.value = bossHPCurr
