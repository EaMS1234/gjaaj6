extends Sprite

var __x = load("res://assets/graphics/icon_1.png")
var __y = load("res://assets/graphics/icon_2.png")

func _on_botao_area_click():
	if self.texture != __x:
		self.texture = __x
	
	elif self.texture != __y:
		self.texture = __y
