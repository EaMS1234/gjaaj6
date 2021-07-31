extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

var pre = preload("res://cenas/fases/fase_1/pre.tscn").instance()
var branco = preload("res://cenas/base/branco.tscn")
var brc =  preload("res://cenas/base/branco.tscn").instance()

var tile_norm = load("res://assets/graphics/tile_presente.tres")
var tile_viaj = load("res://assets/graphics/tile_viagem.tres")

var tempo = 1  # 0 = PASSADO. 1 = PRESENTE. 2 = FUTURO.
var x = 0
var y = 0
var z = 0
var a = 0

func _ready():
	$player_area.screen_size = $ReferenceRect.rect_size
	
	var dia = txt.instance()
	dia.txt_pos = "2.0"
	add_child(dia)

func _physics_process(_delta):
	if branco in self.get_children():
		if branco.x >= 0.005:
			$player_clone.visible = true
			y += 1
		
	if y == 200:
		$botao_area.clicked += 1
	
	$porta_area.show()
	
	if $botao_area.clicked == $botao_area.max_click:
		$porta_area/porta_col.disabled = false
			
		if $porta_area/porta_audio.get_playback_position() >= 4.6:
			$porta_area/porta_audio.stream_paused = true
		
		else:
			$porta_area/porta_audio.stream_paused = false
		
		if $porta_area/porta_sprite.frame == 0 and $porta_area/porta_audio.get_playback_position() > 1.2:
			$porta_area/porta_sprite.play()
	
	$bg.animation = "pre"
	
	if not pre in self.get_children():
		self.add_child(pre)
	
	if $__TILE.dispo_pre == false:
		$__TILE.collision_layer = 2
		$__TILE.collision_mask = 2
		$__TILE.hide()
	
	else:
		$__TILE.tile_set = tile_norm
		$__TILE.collision_layer = 1
		$__TILE.collision_mask = 1
		$__TILE.show()
	
	if $porta_area/porta_audio.get_playback_position() >= 4.6:
		$porta_area/porta_audio.stream_paused = true
	
	if $porta_area/porta_sprite.frame == 8:
		$porta_area/porta_sprite.stop()
		
		if z == 0:
			brc.alvo = 1
			get_tree().get_nodes_in_group("__sala")[0].add_child(brc)
			$player_area.movable = false
		
			z += 1
		
		if a == 0:
			
			var dia = txt.instance()
			dia.txt_pos = "2.1"
			add_child(dia)
			
			a += 1
		
	if brc in self.get_children():
		if brc.visible == false:
			$player_clone.visible = false

func _on_porta_area_area_entered(area):
	var trans = load("res://cenas/base/preto.tscn").instance()
	
	if area.get_parent() in get_tree().get_nodes_in_group("__player") and not trans in get_parent().get_parent().get_children():
		area.get_parent().movable = false
		get_parent().get_parent().add_child(trans)

func _on_gatilho_area_entered(area):
	if area.get_parent() in get_tree().get_nodes_in_group("__player") and x == 0:
		branco = branco.instance()
		
		branco.alvo = 1
		get_tree().get_nodes_in_group("__sala")[0].add_child(branco)
		$player_area.movable = false
		
		x += 1
