extends Control

@onready var gameScene = get_parent().get_parent()
@onready var playerHP = $PlayerHP
@onready var bossHP = $BossHP

var transitionTime = 1


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

func Boss_HP_Bar():
	var tween = create_tween()
	tween.parallel().tween_property(bossHP, "position", Vector2(1280,0), transitionTime)
