extends Node

@onready var gameScene = get_parent()
@onready var tipWindow = $TipWindow
@onready var tipLabel = $TipWindow/PanelContainer/Label
@onready var timer = $Timer

var hasTakenDamage = false
var bossWave = false
var bossHasTakenDamage = false

var tipDict = {
	'HP': 'You can regain a little bit of HP by eating MOSQUITOS.',
	'DMG': 'You can kill the BOSS by clicking on it with your MOUSE.',
	'Test': 'This is a test tip.'
}



func Tip_Tweener():
	Fix_Anchors()
	
	var tween = create_tween()
	
	tween.parallel().tween_property(tipWindow, "position", Vector2(tipWindow.position.x,990), .25)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()
	
	await(get_tree().create_timer(7).timeout)
	
	var tween2 = create_tween()
	tween2.parallel().tween_property(tipWindow, "position", Vector2(tipWindow.position.x,1100), .25)
	tween2.set_ease(Tween.EASE_IN_OUT)
	tween2.play()

func Fix_Anchors():
	tipWindow.anchor_left = .5
	tipWindow.anchor_right = .5
	
	tipWindow.grow_horizontal = 3
	
func Damage_Taken_Tip():
	if !Global.tipTriggers['hasTakenDamage']:
		Global.tipTriggers['hasTakenDamage'] = true
		tipLabel.text = tipDict['HP']
		Tip_Tweener()
	
func Boss_Wave_Tip():
	if !Global.tipTriggers['hasDamagedBoss']:
		Global.tipTriggers['hasDamagedBoss'] = true
		
		await(get_tree().create_timer(10).timeout)
		
		tipLabel.text = tipDict['DMG']
		Tip_Tweener()

func Test_Tip():
	if !Global.tipTriggers['testTip']:
		Global.tipTriggers['testTip'] = true
		
		await(get_tree().create_timer(5).timeout)
		
		tipLabel.text = tipDict['Test']
		Tip_Tweener()
		
		
func _on_timer_timeout():
	tipLabel.text = tipDict['DMG']
	Tip_Tweener()
	
