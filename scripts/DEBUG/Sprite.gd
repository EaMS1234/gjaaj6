extends Sprite

var __x = load("res://assets/graphics/icon_1.png")
var __y = load("res://assets/graphics/icon_2.png")

func _on_pplaca_area_press():
	self.texture = __y

func _on_pplaca_area_unpress():
	self.texture = __x
