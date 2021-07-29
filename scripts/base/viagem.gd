extends Polygon2D

const branco = preload("res://cenas/base/branco.tscn")

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
		
		queue_free()
	
	elif Input.is_action_just_pressed("ui_left"):
		if cursor > 0:
			cursor -= 1
		
	elif Input.is_action_just_pressed("ui_right"):
		if cursor < 2:
			cursor += 1
	
	if cursor == 0:
		$pa.offset.y = -240
		$pre.offset.y = 0
		$fu.offset.y = 0
	
	elif cursor == 1:
		$pa.offset.y = 0
		$pre.offset.y = -240
		$fu.offset.y = 0
	
	elif cursor == 2:
		$pa.offset.y = 0
		$pre.offset.y = 0
		$fu.offset.y = -240

func _viagem():
	if get_parent().tempo == cursor:
		get_tree().get_nodes_in_group("__player")[0].erro("Você já está nesta linha do tempo.")

		for node in get_tree().get_nodes_in_group("__player"):
			node.movable = true

	else:
		if cursor == 0:
			var trans = branco.instance()
			trans.alvo = 0
			get_tree().get_nodes_in_group("__sala")[0].add_child(trans)
		
		elif cursor == 1:
			var trans = branco.instance()
			trans.alvo = 1
			get_tree().get_nodes_in_group("__sala")[0].add_child(trans)
		
		elif cursor == 2:
			var trans = branco.instance()
			trans.alvo = 2
			get_tree().get_nodes_in_group("__sala")[0].add_child(trans)
