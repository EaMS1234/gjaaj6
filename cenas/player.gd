# Movimento do jogador

extends Area2D

export var velo = 150  # Velocidade (pixel/sec)

var mov = Vector2()  # Movimento 2D

func _physics_process(delta):
	if Input.is_action_pressed("ui_down"):
		mov.y += velo
	
	if Input.is_action_pressed("ui_up"):
		mov.y -= velo
	
	if Input.is_action_pressed("ui_left"):
		mov.x -= velo
	
	if Input.is_action_pressed("ui_right"):
		mov.x += velo
	
	if Input.is_action_pressed("ui_accept"):
		pass
	
	if mov.length() >= velo:
		# Impede de se mover mais rapido que a velocidade estabelecida
		mov = mov.normalized() * velo
	
	self.position += mov * delta
	
	mov = mov * 0  # Jogador para quando nao esta recebendo nenhuma força
