extends ParallaxBackground


func _process(delta):
	scroll_base_offset.x -= 100 * delta
