extends Area2D

export var default_time = 1

var normal = load("res://assets/graphics/Caixa/Caixa_0.png")
var travel = load("res://assets/graphics/Viagem no tempo/caixapassado.png")

func _physics_process(_delta):
	if get_tree().get_nodes_in_group("__sala")[0].tempo == 1:
		$caixa_sprite.texture = normal
	
	else:
		$caixa_sprite.texture = travel
