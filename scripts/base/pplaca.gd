extends Area2D

signal press
signal unpress

var ativ = false

func _physics_process(delta):
	if ativ:
		if get_parent().tempo == 1:
			$pplaca_sprite.animation = "activate"
		
		else:
			$pplaca_sprite.animation = "activate_p"
	
	else:
		if get_parent().tempo == 1:
			$pplaca_sprite.animation = "default"
		
		else:
			$pplaca_sprite.animation = "default_p"

func _on_pplaca_area_area_entered(area):
	if area in get_tree().get_nodes_in_group("__caixa"):
		ativ = true
		
		emit_signal("press")

func _on_pplaca_area_area_exited(area):
	if area in get_tree().get_nodes_in_group("__caixa"):
		ativ = false
		
		emit_signal("unpress")
