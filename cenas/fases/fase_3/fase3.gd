extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

var pre = preload("res://cenas/fases/fase_1/pre.tscn").instance()

var tile_norm = load("res://assets/graphics/tile_presente.tres")
var tile_viaj = load("res://assets/graphics/tile_viagem.tres")

var tempo = 1  # 0 = PASSADO. 1 = PRESENTE. 2 = FUTURO.

var gat = false
var rep = 0

func _ready():
	$player_area.screen_size = $ReferenceRect.rect_size
	
	var dia = txt.instance()
	
	dia.txt_pos = "3.0"
	
	add_child(dia)

func _physics_process(_delta):
	if gat:
		$porta_area/porta_col.disabled = false
	
	$porta_area.show()
	
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

func _on_porta_area_area_entered(area):
	var trans = load("res://cenas/base/preto.tscn").instance()
	
	if area.get_parent() in get_tree().get_nodes_in_group("__player") and not trans in get_parent().get_parent().get_children():
		area.get_parent().movable = false
		get_parent().get_parent().add_child(trans)

func _on_pplaca_area_press():
	if rep == 0:
		var dia = txt.instance()
		
		dia.txt_pos = "3.1"
		
		add_child(dia)
		
		$porta_area/porta_audio.stream_paused = false
		$porta_area/porta_sprite.play()
		
		gat = true
		
		rep += 1
