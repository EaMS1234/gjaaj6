# Movimento do jogador

extends Area2D

const spawn_caixa = preload("res://cenas/caixa.tscn")

export var velo = 150  # Velocidade (pixel/sec)

var ready_caixa
var mov = Vector2()  # Movimento 2D
var caixa = false
var botao = false
var pegou = false

func _physics_process(delta):
	if Input.is_action_pressed("ui_down"):
		mov.y += velo
	
	if Input.is_action_pressed("ui_up"):
		mov.y -= velo
	
	if Input.is_action_pressed("ui_left"):
		mov.x -= velo
	
	if Input.is_action_pressed("ui_right"):
		mov.x += velo
	
	if Input.is_action_just_pressed("ui_accept"):
		if caixa == true and pegou == false:
			pegou = true
			
			$player_sprite.animation = "carregando"
			
			ready_caixa.queue_free()  # Apaga a caixa da memoria
		
		elif caixa == false and botao == false and pegou == true:
			pegou = false
			
			$player_sprite.animation = "default"
			
			var __nova_caixa = spawn_caixa.instance()  # Instancia a caixa para ser adicionada posteriormente
			__nova_caixa.position = self.position  # Posiçao da caixa e a mesma do player
			get_parent().add_child(__nova_caixa)  # Spawna uma nova caixa

	if mov.length() >= velo:
		# Impede de se mover mais rapido que a velocidade estabelecida
		mov = mov.normalized() * velo
	
	self.position += mov * delta
	
	mov = mov * 0  # Jogador para quando nao esta recebendo nenhuma força
	
func _on_player_area_area_entered(area):  # ENTROU
	if area in get_tree().get_nodes_in_group("__obj"):
		pass  # SUBSTITUIR
	
	if area in get_tree().get_nodes_in_group("__caixa"):
		caixa = true
		
		ready_caixa = area
	
	if area in get_tree().get_nodes_in_group("__botao"):
		botao = true
		
func _on_player_area_area_exited(area):  # SAIU
	if area in get_tree().get_nodes_in_group("__obj"):
		pass  # SUBSTITUIR
		
	if area in get_tree().get_nodes_in_group("__caixa"):
		caixa = false
	
	if area in get_tree().get_nodes_in_group("__botao"):
		botao = false
