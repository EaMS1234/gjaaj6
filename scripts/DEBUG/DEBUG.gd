# CENA DE EXEMPLO

extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

var pa = preload("res://cenas/fases/DEBUG/pa.tscn").instance()
var pre = preload("res://cenas/fases/DEBUG/pre.tscn").instance()
var fu = preload("res://cenas/fases/DEBUG/fu.tscn").instance()

var tempo = 1  # 0 = PASSADO. 1 = PRESENTE. 2 = FUTURO.

func _physics_process(delta):
	if tempo == 0:
		$bg.animation = "pa"
		$Label.text = "PASSADO"
		
		self.add_child(pa)
		self.remove_child(pre)
		self.remove_child(fu)
	
	elif tempo == 1:
		$bg.animation = "pre"
		$Label.text = "PRESENTE"
		
		self.remove_child(pa)
		self.add_child(pre)
		self.remove_child(fu)
		
	elif tempo == 2:
		$bg.animation = "fu"
		$Label.text = "FUTURO"
		
		self.remove_child(pa)
		self.remove_child(pre)
		self.add_child(fu)

func _on_botao_area2_click():
	var dia = txt.instance()
	
	dia.txt_pos = "0.2"
	
	add_child(dia)
