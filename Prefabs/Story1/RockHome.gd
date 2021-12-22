extends Node2D

var dirtyState = 2

func _ready():
	pass # Replace with function body.

func _process(delta):
	$Sprite.frame = dirtyState

func _on_Area2D_area_entered(area):
	dirtyState -= 1
	dirtyState = clamp(dirtyState, 0, 2)
	if GameController.story_controller.story_result[0] == 0:
		GameController.story_controller.story_result[0] = 2
	elif GameController.story_controller.story_result[0] == 1:
		GameController.story_controller.story_result[0] = 3
	pass # Replace with function body.
