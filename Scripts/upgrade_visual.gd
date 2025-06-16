extends TextureProgressBar

var upgradeNumber : int = 0

@onready var timer = $Timer

	
func _process(delta):
	value = timer.time_left * 100

func _on_timer_timeout():
	if upgradeNumber == 1:
		UpgradeText.scoreMultiplier = 1
	if upgradeNumber == 3:
		UpgradeText.healsOverTime = false
	if upgradeNumber == 4:
		UpgradeText.Vulture(true)
	if upgradeNumber == 6:
		UpgradeText.Mossy_Magnet(true)
	queue_free()
