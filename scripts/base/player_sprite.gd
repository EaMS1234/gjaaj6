extends AnimatedSprite

func _physics_process(_delta):
	if "c_" in self.animation:
		self.offset.y = -80
	
	else:
		self.offset.y = 0
