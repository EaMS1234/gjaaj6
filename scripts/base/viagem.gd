extends Polygon2D

signal pa
signal pre
signal fu
signal atual

var cursor = 1

func _ready():
	cursor = get_parent().tempo
	
	for node in get_tree().get_nodes_in_group("__player"):
		node.movable = false
	
func _physics_process(delta):
	if Input.is_action_just_pressed("viagem"):
		_viagem()
		
		for node in get_tree().get_nodes_in_group("__player"):
			node.movable = true
		
		queue_free()
	
	elif Input.is_action_just_pressed("ui_left"):
		if cursor > 0:
			cursor -= 1
		
	elif Input.is_action_just_pressed("ui_right"):
		if cursor < 2:
			cursor += 1
	
	if cursor == 0:
		$pa.offset.y = -25
		$pre.offset.y = 0
		$fu.offset.y = 0
	
	elif cursor == 1:
		$pa.offset.y = 0
		$pre.offset.y = -25
		$fu.offset.y = 0
	
	elif cursor == 2:
		$pa.offset.y = 0
		$pre.offset.y = 0
		$fu.offset.y = -25

func _viagem():
	if get_parent().tempo == cursor:
		print("JA ESTA NO TEMPO ALVO")
	
	else:
		if cursor == 0:
			print("VIAJANDO PARA O PASSADO")
			
			get_parent().tempo = 0
		
		elif cursor == 1:
			print("VIAJANDO PARA O PRESENTE")
			
			get_parent().tempo = 1
		
		elif cursor == 2:
			print("VIAJANDO PARA O FUTURO")
			
			get_parent().tempo = 2
