extends Label

var x = 0

func _physics_process(delta):
	if x < 1:
		x += 0.01
	
	else:
		queue_free()
