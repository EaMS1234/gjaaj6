# Movimento do jogador

extends Area2D

const spawn_caixa = preload("res://cenas/base/caixa.tscn")
const viagem = preload("res://cenas/base/viagem.tscn")

export var velo = 150  # Velocidade (pixel/sec)

var fase
var ready_caixa
var ready_caixa_nome
var mov = Vector2()  # Movimento 2D
var caixa = false
var botao = false
var pegou = false
var obj = false
var movable = true  # Jogador e movimentavel?

func _physics_process(delta):
	fase = get_tree().get_nodes_in_group("__fase")[0]
	
	if Input.is_action_just_released("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if movable:
		if Input.is_action_pressed("ui_down"):
			mov.y += velo
			
			if pegou == false:
				$player_sprite.animation = "a_frente"
			
			else:
				if get_parent().tempo == 1:
					$player_sprite.animation = "c_frente"
				
				else:
					$player_sprite.animation = "c_frente_p"
			
			$player_sprite.play()
		
		elif Input.is_action_pressed("ui_up"):
			mov.y -= velo
			
			if pegou == false:
				$player_sprite.animation = "a_cima"
			
			else:
				if get_parent().tempo == 1:
					$player_sprite.animation = "c_cima"
				
				else:
					$player_sprite.animation = "c_cima_p"
			
			$player_sprite.play()
		
		elif Input.is_action_pressed("ui_left"):
			mov.x -= velo
			
			$player_sprite.flip_h = true
			
			if pegou == false:
				$player_sprite.animation = "a_lado"
			
			else:
				if get_parent().tempo == 1:
					$player_sprite.animation = "c_lado"
				
				else:
					$player_sprite.animation = "c_lado_p"
			
			$player_sprite.play()
		
		elif Input.is_action_pressed("ui_right"):
			mov.x += velo
			
			$player_sprite.flip_h = false
			
			if pegou == false:
				$player_sprite.animation = "a_lado"
			
			else:
				if get_parent().tempo == 1:
					$player_sprite.animation = "c_lado"
				
				else:
					$player_sprite.animation = "c_lado_p"
			
			$player_sprite.play()
		
		if Input.is_action_just_pressed("ui_accept"):
			if caixa == true and pegou == false:
				pegou = true
				
				if get_parent().tempo == 1:
					$player_sprite.animation = "c_frente"
				
				else:
					$player_sprite.animation = "c_frente_p"
				
				$player_sprite.play()
				
				ready_caixa_nome = ready_caixa.name
				
				ready_caixa.queue_free()  # Apaga a caixa da memoria
			
			elif caixa == false and botao == false and pegou == true:
				pegou = false
				
				$player_sprite.animation = "a_frente"
				$player_sprite.play()
				
				var __nova_caixa = spawn_caixa.instance()  # Instancia a caixa para ser adicionada posteriormente
				__nova_caixa.position = self.position  # Posiçao da caixa e a mesma do player
				__nova_caixa.name = ready_caixa_nome
				
				fase.add_child(__nova_caixa)
				
				if get_parent().tempo == 0:
					for node in get_parent().pre.get_children():
						if node.name == ready_caixa_nome:
							node.position = __nova_caixa.position
					
					for node in get_parent().fu.get_children():
						if node.name == ready_caixa_nome:
							node.position = __nova_caixa.position
				
				elif get_parent().tempo == 1:
					for node in get_parent().fu.get_children():
						if node.name == ready_caixa_nome:
							node.position = __nova_caixa.position

		elif Input.is_action_just_pressed("viagem"):
			var spawn_viagem = viagem.instance()
			
			self.get_parent().add_child(spawn_viagem)
		
	if mov.length() >= velo:
		# Impede de se mover mais rapido que a velocidade estabelecida
		mov = mov.normalized() * velo
	
	if mov.length() == 0:
		$player_sprite.frame = 1
		$player_sprite.stop()
	
	if $bolha.frame == 16:
		if obj == false:
			$bolha.visible = false
		
		else:
			$bolha.stop()
	
	self.position += mov * delta
	
	mov = mov * 0  # Jogador para quando nao esta recebendo nenhuma força
	
func _on_player_area_area_entered(area):  # ENTROU
	if area in get_tree().get_nodes_in_group("__obj"):
		$bolha.visible = true
		$bolha.animation = "default"
		$bolha.play()
		
		obj = true
	
	if area in get_tree().get_nodes_in_group("__caixa"):
		caixa = true
		
		ready_caixa = area
	
	if area in get_tree().get_nodes_in_group("__botao"):
		botao = true
		
func _on_player_area_area_exited(area):  # SAIU
	if area in get_tree().get_nodes_in_group("__obj"):
		$bolha.visible = true
		$bolha.animation = "reverso"
		$bolha.play()
		
		obj = false

	if area in get_tree().get_nodes_in_group("__caixa"):
		caixa = false
	
	if area in get_tree().get_nodes_in_group("__botao"):
		botao = false
