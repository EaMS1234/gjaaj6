extends AnimatedSprite

func _physics_process(delta):
	if self.animation == "c_frente":
		self.offset.y = -80
	
	else:
		self.offset.y = 0
