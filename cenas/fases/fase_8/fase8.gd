extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

var pre = preload("res://cenas/fases/fase_8/pre.tscn").instance()

var branco = preload("res://cenas/base/branco.tscn")

var tile_norm = load("res://assets/graphics/tile_presente.tres")
var tile_viaj = load("res://assets/graphics/tile_viagem.tres")

var tempo = 1  # 0 = PASSADO. 1 = PRESENTE. 2 = FUTURO.

var x = 0
var y = 0

func _ready():
	$player_area.screen_size = $ReferenceRect.rect_size
	
	var dia = txt.instance()
	dia.txt_pos = "8.0"
	add_child(dia)

func _physics_process(_delta):
	if tempo == 1:
		if not pre in self.get_children():
			self.add_child(pre)
		
	elif tempo == 0:
		for node in get_children():
			if node.name == "__TILE":
				$__TILE.queue_free()
		
		$__TILE2.visible = true
		$__TILE2.collision_use_parent = false
		
		$bg.animation = "pa"
		
		if x == 1:
			$Sprite2.visible = true
			$botao_area.max_click += 1
			
			var dia = txt.instance()
			dia.txt_pos = "2.0"
			add_child(dia)
			
			x += 1
	
	elif tempo == 2:
		$Polygon2D.visible = true
		$player_area/bolha.visible = false
		
		for node in get_children():
			if node.name == "__TILE2" or node.name == "botao_area":
				node.queue_free()
		
		if x == 3:
			
			var dia = txt.instance()
			dia.txt_pos = "8.1"
			add_child(dia)
			
			x += 1
			
		if x == 4:
			for node in get_tree().get_nodes_in_group("__TEXTOO"):
				if node.x >= len(node.lines):
					var trans = load("res://cenas/base/preto.tscn").instance()
					$player_area.movable = false
					get_parent().get_parent().add_child(trans)

func _on_botao_area_click():
	$player_area.movable = false
	
	if x == 0:
		var br = branco.instance()
		
		br.alvo = 0
		get_tree().get_nodes_in_group("__sala")[0].add_child(br)
		
		x += 1
		
	else:
		var brc = branco.instance()
		
		brc.alvo = 2
		get_tree().get_nodes_in_group("__sala")[0].add_child(brc)

		x += 1
