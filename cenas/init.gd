extends Node

var trans = preload("res://cenas/base/preto.tscn").instance()

var fases = [
	preload("res://cenas/fases/fase_1/fase1.tscn"),
	preload("res://cenas/fases/fase_2/fase2.tscn"),
	preload("res://cenas/fases/fase_3/fase3.tscn"),
	preload("res://cenas/fases/fase_4/fase4.tscn"),
	preload("res://cenas/fases/fase_5/fase5.tscn"),
	preload("res://cenas/fases/fase_6/fase6.tscn"),
	preload("res://cenas/fases/fase_7/fase7.tscn"),
	preload("res://cenas/fases/DEBUG/DEBUG.tscn")
]  # Conjunto das fases (EM ORDEM)

var intro_text = [
	"",
	"Erick Augusto AKA. EaMS1234\ne\nLucas Morosini AKA. zLuckzz\napresentam...",
	"Um jogo para a GAME JAAJ 6",
	"Um jogo para a GAME JAAJ 6\nTEMA: CICLOS",
	"Gameplay e Programação por",
	"Gameplay e Programação por\n\nEaMS1234",
	"Gráficos, Sons e Músicas por",
	"Gráficos, Sons e Músicas por\n\nzLuckzz",
	""
]

var fase_num = -1
var __start = false
var x = 0

func _ready():
	for node in self.get_children():
		if node.get_class() != "Node" and node.get_class() != "Polygon2D" and node.get_class() != "Timer":
			node.visible = false
		
	$text1.text = intro_text[0]
	$text1.visible = true

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("ui_accept") and __start == false:
		if len(intro_text) > x:
			x += len(intro_text)
		
		else:
			$musica.fade = true
			
			if not trans in get_children():
				add_child(trans)
				__start = true

func _on_timer_texto_timeout():
	x += 1
	
	if len(intro_text) > x:
		$text1.text = intro_text[x]
	
	else:
		$text1.hide()
		
		$start.visible = !$start.visible
		$logo.visible = true
