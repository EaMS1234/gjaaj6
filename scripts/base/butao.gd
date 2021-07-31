extends Area2D

signal click

export var max_click = 3  # Quantidade de clicks

var clickable = false
var clicked = 0  # Vezes clicadas

func _physics_process(_delta):
	if clickable and Input.is_action_just_pressed("ui_accept") and clicked < max_click:
		get_tree().get_nodes_in_group("__player")[0].get_child(5).stream_paused = false
		get_tree().get_nodes_in_group("__player")[0].get_child(5).play(0.0)
		
		if get_parent().tempo == 1:
			$botao_sprite.animation = "pressed"
		
		else:
			$botao_sprite.animation = "pressed-p"
		
		emit_signal("click")
		
		clicked += 1
		
		print(clicked)
	
	elif clicked == max_click:
		if get_parent().tempo == 1:
			$botao_sprite.animation = "pressed"
		
		else:
			$botao_sprite.animation = "pressed-p"
	
	else:
		if get_parent().tempo == 1:
			$botao_sprite.animation = "default"
		
		else:
			$botao_sprite.animation = "default-p"

func _on_botao_area_area_entered(area):
	if area.get_parent() in get_tree().get_nodes_in_group("__player") and area.get_parent().pegou == false:
		clickable = true

func _on_botao_area_area_exited(area):
	if area.get_parent() in get_tree().get_nodes_in_group("__player"):
		clickable = false
