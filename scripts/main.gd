# CENA DE EXEMPLO

extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/dialog.tscn")

func _on_botao_area2_click():
	var dia = txt.instance()
	
	dia.fase = 0
	dia.ordem = 1
	
	add_child(dia)
