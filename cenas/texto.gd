extends Label

export var _txt_velo = 0.025

func _ready():
	self.percent_visible = 0

func _physics_process(delta):
	self.percent_visible += _txt_velo

func _on_texto_hide():
	_ready()
