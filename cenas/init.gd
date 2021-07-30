extends Node

var fases = [
	preload("res://cenas/fases/DEBUG/DEBUG.tscn")
]  # Conjunto das fases (EM ORDEM)

var intro_text = [
	"",
	"Erick Augusto AKA. EaMS1234\ne\nLucas Morosini AKA. zLuckzz\napresentam...",
	"Um jogo para a GAME JAAJ 6",
	"Um jogo para a GAME JAAJ 6\nTEMA: CICLOS",
	"Gameplay e Programaçao por",
	"Gameplay e Programaçao por\n\nEaMS1234",
	"Graficos, Sons e Musicas por",
	"Graficos, Sons e Musicas por\n\nzLuckzz",
	""
]

var x = 0

func _ready():
	for node in self.get_children():
		if node.get_class() != "Node" and node.get_class() != "Polygon2D" and node.get_class() != "Timer":
			node.visible = false
		
	$text1.text = intro_text[0]
	$text1.visible = true

func _on_timer_texto_timeout():
	x += 1
	
	if len(intro_text) > x:
		$text1.text = intro_text[x]
	
	else:
		$text1.hide()
		
		$start.visible = !$start.visible
		$logo.visible = true
