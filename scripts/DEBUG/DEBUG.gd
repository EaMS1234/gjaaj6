# CENA DE EXEMPLO

extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

var tempo = 1  # 0 = PASSADO. 1 = PRESENTE. 2 = FUTURO.

func _physics_process(delta):
	if tempo == 0:
		$Label.text = "PASSADO"
	
	elif tempo == 1:
		$Label.text = "PRESENTE"
	
	elif tempo == 2:
		$Label.text = "FUTURO"

func _on_botao_area2_click():
	var dia = txt.instance()
	
	dia.txt_pos = "0.2"
	
	add_child(dia)
