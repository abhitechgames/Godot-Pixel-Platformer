extends ParallaxBackground

var scrolling_speed = 100

func _process(delta):
	scroll_offset.x -= delta * scrolling_speed
