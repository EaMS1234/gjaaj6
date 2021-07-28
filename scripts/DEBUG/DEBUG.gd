# CENA DE EXEMPLO

extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/base/dialog.tscn")

func _on_botao_area2_click():
	var dia = txt.instance()
	
	dia.txt_pos = "0.2"
	
	add_child(dia)
