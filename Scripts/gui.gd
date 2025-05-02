extends Control

@onready var gameScene = get_parent().get_parent()
@onready var playerHP = $PlayerHP
@onready var bossHP = $BossHP
@onready var playerES = $PlayerES

var transitionTime = 1


func _ready():
	bossHP.hide()
	
	
func _process(delta):
	Update_Player_HP()
	Update_Player_ES()


func Update_Player_HP():
	var playerHPCurr = gameScene.player.HP
	playerHP.value = playerHPCurr
	
func Update_Player_ES():
	var playerESCurr = gameScene.player.ES
	playerES.value = playerESCurr

func Update_Boss_HP(hp):
	var bossHPCurr = hp
	bossHP.value = bossHPCurr

func Boss_HP_Bar():
	var tween = create_tween()
	tween.parallel().tween_property(bossHP, "position", Vector2(1280,0), transitionTime)

func Update_Wave_Counter(x):
	$Wave.text = 'Wave: ' + str(x)
