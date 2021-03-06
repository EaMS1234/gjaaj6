# Movimento do jogador

extends RigidBody2D

const spawn_caixa = preload("res://cenas/base/caixa.tscn")
const viagem = preload("res://cenas/base/viagem.tscn")
const unable = preload("res://cenas/base/msg_erro.tscn")

export var velo = 150  # Velocidade (pixel/sec)
export var cooldown = 50
export var viajable = true
export var cooldown_enable = true

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
var movable = true  # Jogador e movimentavel?]
var block = false
var viajable_motivo = "Você não pode fazer isto agora."

func _integrate_forces(_state):
	set_scale(Vector2(0.75, 0.75))

func _physics_process(delta):
	refresh_time += 1
	
	var fase = get_tree().get_nodes_in_group("__fase")[0]

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
				
				$pegar.stream_paused = false
				$pegar.play(0.0)
				
				if get_parent().tempo == 1:
					$player_sprite.animation = "c_frente"
				
				else:
					$player_sprite.animation = "c_frente_p"
				
				$player_sprite.play()
				
				ready_caixa_nome = ready_caixa.name
				ready_caixa_tempo = ready_caixa.default_time

				ready_caixa.queue_free()  # Apaga a caixa da memoria
			
			elif caixa == false and botao == false and pegou == true:
				if block == false:
					pegou = false
					
					$pegar.stream_paused = false
					$pegar.play(0.0)
					
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
						for item in get_parent().get_children():
							if item.name == "fu":
								for node in get_parent().fu.get_children():
									if node.name == ready_caixa_nome:
										node.position = __nova_caixa.position
				
				else:
					erro(viajable_motivo)

		elif Input.is_action_just_pressed("viagem"):
			if viajable == true and block == false:
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
		
		$passos.stream_paused = false
		
	if mov.length() == 0:
		$passos.stream_paused = true
		
		$player_sprite.frame = 1
		$player_sprite.stop()
	
	if $bolha.frame == 16:
		if obj == false:
			$bolha.visible = false
		
		else:
			$bolha.stop()
	
	if $pegar.get_playback_position() >= 1.6:
		$pegar.stream_paused = true
		$pegar.play(0.0)
	
	if refresh_time <= cooldown:
		viajable = false
	
	elif cooldown_enable == true:
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
	
	if area in get_tree().get_nodes_in_group("__block"):
		block = true

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
	
	if area in get_tree().get_nodes_in_group("__block"):
		block = false
