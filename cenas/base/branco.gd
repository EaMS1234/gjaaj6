extends Polygon2D

var x = float(0)
var etapa = 0

var alvo = 1

func _ready():
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	self.color = Color(255, 255, 255, x)
	
	if etapa == 0:
		x += 0.000025
		
		if x >= 0.005:
			for node in get_tree().get_nodes_in_group("__sala"):
				node.tempo = alvo
			
			for node in get_tree().get_nodes_in_group("__player"):
				node.movable = true
				
			self.visible = false

	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	
	if $AudioStreamPlayer2D.get_playback_position() >= 7:
		queue_free()
