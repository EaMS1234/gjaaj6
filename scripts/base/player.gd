# Movimento do jogador

extends KinematicBody2D

const spawn_caixa = preload("res://cenas/base/caixa.tscn")
const viagem = preload("res://cenas/base/viagem.tscn")
const unable = preload("res://cenas/base/msg_erro.tscn")

export var velo = 150  # Velocidade (pixel/sec)
export var cooldown = 50
export var viajable = true

var refresh_time = 0
var screen_size
var ready_caixa
var ready_caixa_nome
var ready_caixa_tempo
var mov = Vector2()  # Movimento 2D
var caixa = false
var botao = false
var pegou = false
var obj = false
var movable = true  # Jogador e movimentavel?
var viajable_motivo = "Você não pode fazer isto agora."

func _physics_process(delta):
	refresh_time += 1
	
	var fase = get_tree().get_nodes_in_group("__fase")[0]
	
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
				ready_caixa_tempo = ready_caixa.default_time

				ready_caixa.queue_free()  # Apaga a caixa da memoria
			
			elif caixa == false and botao == false and pegou == true:
				pegou = false
				
				$player_sprite.animation = "a_frente"
				$player_sprite.play()
				
				var __nova_caixa = spawn_caixa.instance()  # Instancia a caixa para ser adicionada posteriormente
				__nova_caixa.position = self.position  # Posiçao da caixa e a mesma do player
				__nova_caixa.name = ready_caixa_nome
				__nova_caixa.default_time = ready_caixa_tempo
				
				fase.add_child(__nova_caixa)
				
				ready_caixa_tempo = null
				
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
			if viajable:
				var spawn_viagem = viagem.instance()
				
				self.get_parent().add_child(spawn_viagem)
			
			else:
				if refresh_time <= cooldown:
					erro("Recarregando viagem no tempo. Aguarde.")
				
				else:
					erro(viajable_motivo)
		
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
	
	if refresh_time <= cooldown:
		viajable = false
	
	else:
		viajable = true
	
	position.x = clamp(position.x, 112, screen_size.x)
	position.y = clamp(position.y, 56, screen_size.y)
	
	self.position += mov * delta
	
	mov = mov * 0  # Jogador para quando nao esta recebendo nenhuma força

func erro(msg):
	var txt = unable.instance()
	txt.add_to_group("__erros")
	
	for node in get_tree().get_nodes_in_group("__erros"):
		node.queue_free()
		
	txt.text = msg
	get_parent().add_child(txt)

func _on_Area2D_area_entered(area):
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

func _on_Area2D_area_exited(area):
	if area in get_tree().get_nodes_in_group("__obj"):
		$bolha.visible = true
		$bolha.animation = "reverso"
		$bolha.play()
		
		obj = false

	if area in get_tree().get_nodes_in_group("__caixa"):
		caixa = false
	
	if area in get_tree().get_nodes_in_group("__botao"):
		botao = false
