extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

var pa = preload("res://cenas/fases/fase_4/pa.tscn").instance()
var pre = preload("res://cenas/fases/fase_4/pre.tscn").instance()
var fu = preload("res://cenas/fases/fase_4/fu.tscn").instance()

var tile_norm = load("res://assets/graphics/tile_presente.tres")
var tile_viaj = load("res://assets/graphics/tile_viagem.tres")

var tempo = 1  # 0 = PASSADO. 1 = PRESENTE. 2 = FUTURO.

var gat = false

func _ready():
	$player_area.screen_size = $ReferenceRect.rect_size
	
	var dia = txt.instance()
	
	dia.txt_pos = "7.0"
	
	add_child(dia)

func _physics_process(_delta):
	if tempo == 0:
		$botao_area.visible = false
		$botao_area/botao_collision.disabled = true
		
		$porta_area/porta_col.disabled = true
		$porta_area.hide()
		
		$bg.animation = "pa"
		
		if not pa in self.get_children():
			self.add_child(pa)
		
		if pre in self.get_children():
			self.remove_child(pre)
		
		if fu in self.get_children():
			self.remove_child(fu)
		
		if $__tile_pre.dispo_pa == false:
			$__tile_pre.collision_layer = 2
			$__tile_pre.collision_mask = 2
			$__tile_pre.hide()
		
		else:
			$__tile_pre.tile_set = tile_viaj
			$__tile_pre.collision_layer = 1
			$__tile_pre.collision_mask = 1
			$__tile_pre.show()
		
		if $__tile_pa.dispo_pa == false:
			$__tile_pa.collision_layer = 2
			$__tile_pa.collision_mask = 2
			$__tile_pa.hide()
		
		else:
			$__tile_pa.tile_set = tile_viaj
			$__tile_pa.collision_layer = 1
			$__tile_pa.collision_mask = 1
			$__tile_pa.show()
		
		if $__tile_fu.dispo_pa == false:
			$__tile_fu.collision_layer = 2
			$__tile_fu.collision_mask = 2
			$__tile_fu.hide()
		
		else:
			$__tile_fu.tile_set = tile_viaj
			$__tile_fu.collision_layer = 1
			$__tile_fu.collision_mask = 1
			$__tile_fu.show()
	
	elif tempo == 1:
		$botao_area.visible = true
		$botao_area/botao_collision.disabled = false

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
		
		if pa in self.get_children():
			self.remove_child(pa)
		
		if not pre in self.get_children():
			self.add_child(pre)
		
		if fu in self.get_children():
			self.remove_child(fu)
		
		if $__tile_pre.dispo_pre == false:
			$__tile_pre.collision_layer = 2
			$__tile_pre.collision_mask = 2
			$__tile_pre.hide()
		
		else:
			$__tile_pre.tile_set = tile_norm
			$__tile_pre.collision_layer = 1
			$__tile_pre.collision_mask = 1
			$__tile_pre.show()

		if $__tile_pa.dispo_pre == false:
			$__tile_pa.collision_layer = 2
			$__tile_pa.collision_mask = 2
			$__tile_pa.hide()
		
		else:
			$__tile_pa.tile_set = tile_norm
			$__tile_pa.collision_layer = 1
			$__tile_pa.collision_mask = 1
			$__tile_pa.show()

		if $__tile_fu.dispo_pre == false:
			$__tile_fu.collision_layer = 2
			$__tile_fu.collision_mask = 2
			$__tile_fu.hide()
		
		else:
			$__tile_fu.tile_set = tile_viaj
			$__tile_fu.collision_layer = 1
			$__tile_fu.collision_mask = 1
			$__tile_fu.show()
		
	elif tempo == 2:
		$botao_area.visible = false
		$botao_area/botao_collision.disabled = true
		
		$porta_area/porta_col.disabled = true
		$porta_area.hide()
		
		$bg.animation = "fu"
		
		if pa in self.get_children():
			self.remove_child(pa)
		
		if pre in self.get_children():
			self.remove_child(pre)
		
		if not fu in self.get_children():
			self.add_child(fu)
		
		if $__tile_pre.dispo_fu == false:
			$__tile_pre.collision_layer = 2
			$__tile_pre.collision_mask = 2
			$__tile_pre.hide()
		
		else:
			$__tile_pre.tile_set = tile_viaj
			$__tile_pre.collision_layer = 1
			$__tile_pre.collision_mask = 1
			$__tile_pre.show()

		if $__tile_pa.dispo_fu == false:
			$__tile_pa.collision_layer = 2
			$__tile_pa.collision_mask = 2
			$__tile_pa.hide()
		
		else:
			$__tile_pa.tile_set = tile_viaj
			$__tile_pa.collision_layer = 1
			$__tile_pa.collision_mask = 1
			$__tile_pa.show()
	
		if $__tile_fu.dispo_fu == false:
			$__tile_fu.collision_layer = 2
			$__tile_fu.collision_mask = 2
			$__tile_fu.hide()
		
		else:
			$__tile_fu.tile_set = tile_viaj
			$__tile_fu.collision_layer = 1
			$__tile_fu.collision_mask = 1
			$__tile_fu.show()

	if $porta_area/porta_audio.get_playback_position() >= 4.6:
		$porta_area/porta_audio.stream_paused = true
	
	if $porta_area/porta_sprite.frame == 8:
		$porta_area/porta_sprite.stop()

func _on_porta_area_area_entered(area):
	var trans = load("res://cenas/base/preto.tscn").instance()
	
	if area.get_parent() in get_tree().get_nodes_in_group("__player") and not trans in get_parent().get_parent().get_children():
		area.get_parent().movable = false
		get_parent().get_parent().add_child(trans)


func _on_botao_area_click():
	var dia = txt.instance()
	
	dia.txt_pos = "7.1"
	
	add_child(dia)
