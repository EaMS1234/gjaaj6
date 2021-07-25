extends Area2D

signal click

export var max_click = 3  # Quantidade de clicks

var clickable = false
var clicked = 0  # Vezes clicadas

func _physics_process(delta):
	if clickable and Input.is_action_just_pressed("ui_accept") and clicked < max_click:
		emit_signal("click")
		
		clicked += 1
		
		print(clicked)

func _on_botao_area_area_entered(area):
	if area in get_tree().get_nodes_in_group("__player") and area.pegou == false:
		clickable = true

func _on_botao_area_area_exited(area):
	if area in get_tree().get_nodes_in_group("__player"):
		clickable = false