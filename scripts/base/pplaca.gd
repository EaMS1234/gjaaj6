extends Area2D

signal press
signal unpress

func _on_pplaca_area_area_entered(area):
	if area in get_tree().get_nodes_in_group("__caixa"):
		$pplaca_sprite.animation = "activate"
		emit_signal("press")

func _on_pplaca_area_area_exited(area):
	if area in get_tree().get_nodes_in_group("__caixa"):
		$pplaca_sprite.animation = "default"
		emit_signal("unpress")
