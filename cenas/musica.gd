extends AudioStreamPlayer2D

export var min_vol_db = -80

var fade = false

func _physics_process(delta):
	if fade == true:
		if volume_db > min_vol_db:
			volume_db -= 0.2
		
		if volume_db == min_vol_db:
			self.stop()
