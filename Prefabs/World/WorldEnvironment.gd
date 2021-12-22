extends WorldEnvironment

var blur_value = 0

func _ready():
	GameController.connect("playerHungry", self, "_on_player_hungry")
	GameController.connect("playerNormal", self, "_on_player_normal")
	pass # Replace with function body.

func _process(delta):
	environment.dof_blur_near_amount += blur_value
	environment.dof_blur_near_amount = clamp(environment.dof_blur_near_amount, 0, 0.1)

func _on_player_hungry():
	blur_value = 0.0005;
	
func _on_player_normal():
	blur_value = -0.001;
