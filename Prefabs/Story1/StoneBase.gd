extends Node2D

const DialogTrigger = preload("res://Prefabs/DialogTrigger/DialogTrigger.tscn")
export var npc_name = ""
export var file = ""
var dirtyState = 1
#const EatEffect = preload("")

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

func _on_ApplePicker_body_entered(body):
	body.queue_free()
	$ApplePicker/CollisionShape2D.disabled = true
	if GameController.story_controller.story_result[0] == 0:
		GameController.story_controller.story_result[0] = 1
	elif GameController.story_controller.story_result[0] == 2:
		GameController.story_controller.story_result[0] = 3
	var myTrigger = Utils.instance_scene_on_main(DialogTrigger, global_position)
	myTrigger.set_dialog_path("thanks", "StoneHome")
	pass # Replace with function body.
