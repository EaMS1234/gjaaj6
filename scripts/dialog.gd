extends Polygon2D

export var caminho = "res://assets/mensagens"  # Diretrio dos arquivos de mensagem
export var limite = 183  # Limite de caracteres

var txt_pos = "0.0"
var lines = []
var x = 0

func _ready():
	lines = ler()
	
	for node in get_tree().get_nodes_in_group("__botao"):
		node.clickable = false  # Bloqueia o click de todos os botoes
	
	for node in get_tree().get_nodes_in_group("__player"):
		node.movable = false  # Bloqueia as açoes do jogador

func _physics_process(delta):
	if x >= len(lines):		
		for node in get_tree().get_nodes_in_group("__player"):
			node.movable = true  # Libera as açoes do jogador
		
		queue_free()  # Apaga da memoria
	
	else:
		$texto.text = lines[x]
		
		if Input.is_action_just_pressed("ui_accept"):
			x += 1

func ler(separator=";"):
	var arquivo = File.new()  # Abre o arquivo
	var msg = []
	
	arquivo.open(caminho, File.READ)  # Carrega o arquivo
	
	while not arquivo.eof_reached():
		var line = arquivo.get_line()  # Carrega a linha
		
		# Reconhece a linha como invalida
		if line.count("#") > 0 or line == " " or line == "\n" or not txt_pos in line:
			pass
		
		# Se valida
		else:
			var y = line.split(separator)[1]
			
			if y[0] == " ":
				y = y.lstrip(" ")
			
			if "\n" in y:
				y = y.rstrip("\n")
			
			if len(y) > limite:
				msg.append(y.left(limite))  # Primeiros caracteres (antes do limite)
				msg.append(y.right(limite))  # Ultimos caracteres (depois do limite)
			
			else:
				msg.append(y)  # Adiciona a lista
	
	arquivo.close()  # Fecha o arquivo
	
	return msg  # Retorna a lista
