# CENA DE EXEMPLO

extends Node2D

# Carrega o dialogo
const txt = preload("res://cenas/dialog.tscn")

func _on_botao_area2_click():
	var dia = txt.instance()
	
	# as linhas do dialogo
	dia.lines = [
		"Lorem ipsum dolor sit amet,",
		"consectetur adipiscing elit. Etiam eget ligula eu lectus",
		"lobortis condimentum. Aliquam nonummy auctor massa.",
		"Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
	]
	
	add_child(dia)
