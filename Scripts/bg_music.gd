extends Node



func _on_timer_timeout():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.play()
