extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	GameController.story_controller.seed_i_destroyed += 1;
	if GameController.story_controller.seed_i_destroyed > 3 and GameController.story_controller.story_result[2] == 0:
		GameController.story_controller.story_result[2] = 3
	if GameController.story_controller.seed_i_destroyed > 3 and GameController.story_controller.story_result[2] == 1:
		GameController.story_controller.story_result[2] = 3
	queue_free()
	pass # Replace with function body.
