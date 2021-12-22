extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
	
func _process(delta):
	if not GameController.speaking:
		self.global_position = self.get_global_mouse_position();
