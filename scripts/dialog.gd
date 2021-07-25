extends Polygon2D

var lines = ["Lorem ipsum dolor site amet"]
var x = 0

func _ready():
	for node in get_tree().get_nodes_in_group("__botao"):
		node.clickable = false  # Bloqueia o click de todos os botoes
	
	for node in get_tree().get_nodes_in_group("__player"):
		node.movable = false  # Bloqueia as açoes do jogador

func _physics_process(delta):
	if x >= len(lines):
		for node in get_tree().get_nodes_in_group("__botao"):
			node.clickable = true  # Libera o click de todos os botoes
		
		for node in get_tree().get_nodes_in_group("__player"):
			node.movable = true  # Libera as açoes do jogador
		
		queue_free()  # Apaga da memoria
	
	else:
		$texto.text = lines[x]
		
		if Input.is_action_just_pressed("ui_accept"):
			x += 1
