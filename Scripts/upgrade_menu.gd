extends Control


@onready var gameScene = get_parent().get_parent()


func _ready():
	pass


func _process(delta):
	if self.position.x == 0:
		Global.mouseHovering = true

func _on_back_pressed():
	get_parent().Menu_Close(get_parent().upgradeMenu,get_parent().mainMenu)
	await(get_tree().create_timer(.1).timeout)
	Global.mouseHovering = false
	Global.Save_Game()
	await(get_tree().create_timer(.1).timeout)
	gameScene.player.show()

