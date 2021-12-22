extends Node2D

const DialogTrigger = preload("res://Prefabs/DialogTrigger/DialogTrigger.tscn")
export var dialog_file_happy = ""
export var dialog_file_sad = ""

func _ready():
	pass # Replace with function body.
	
func _on_Area2D_body_entered(body):
	body.queue_free()
	var myTrigger = Utils.instance_scene_on_main(DialogTrigger, global_position)
	myTrigger.set_dialog_path(check_number_destroyed_seed(), "BlueEvil")
	if GameController.story_controller.seed_i_destroyed < 3 and GameController.story_controller.story_result[2] == 0:
		GameController.story_controller.story_result[2] = 1
	if GameController.story_controller.seed_i_destroyed > 3 and GameController.story_controller.story_result[2] == 0:
		GameController.story_controller.story_result[2] = 2
	pass # Replace with function body.

func check_number_destroyed_seed():
	if GameController.story_controller.seed_i_destroyed < 3:
		return dialog_file_happy
	else:
		return dialog_file_sad
	pass
