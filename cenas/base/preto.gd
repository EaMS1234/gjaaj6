extends Polygon2D

var x = 0
var etapa = 0

func _ready():
	$AudioStreamPlayer.play(0.0)
	$AudioStreamPlayer.stream_paused = false
	
	for node in get_tree().get_nodes_in_group("__player"):
		print(node.get_parent().name)

func _physics_process(_delta):
	self.color = Color(255, 255, 255, x)
	
	if $AudioStreamPlayer.get_playback_position() >= 3.3:
		$AudioStreamPlayer.stream_paused = true
	
	if etapa == 0:
		x += 0.000025
			
		if x >= 0.005:
			get_parent().fase_num += 1
				
			var fase = get_parent().fases[get_parent().fase_num].instance()
				
			if get_parent().fase_num != -1:
				if get_parent().get_child(0).get_child_count() > 0:
					for node in get_parent().get_child(0).get_children():
						node.queue_free()
					
			get_parent().get_child(0).add_child(fase)
			
			get_parent().get_child(2).visible = false
			get_parent().get_child(3).visible = false
			get_parent().get_child(4).visible = false
			get_parent().get_child(5).visible = false
			get_parent().get_child(6).stop()
			
			etapa += 1
	
	else:
		x -= 0.00025
		
		if x <= 0:
			print(self.name, " Deletado.")
			
			queue_free()
