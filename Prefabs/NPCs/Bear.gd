extends Node2D

var got_apple = false
var got_crate = false
export var npc_name = ""

const DialogTrigger = preload("res://Prefabs/DialogTrigger/DialogTrigger.tscn")
export var apple_file = ""
export var crate_file = ""

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.collision_layer == 10 and not got_apple:
		got_apple = true
		trigger_dialog(body, apple_file)
		check_animator()
	if body.collision_layer == 66 and not got_crate and got_apple:
		GameController.story_controller.story_result[1] = 2
		got_crate = true
		trigger_dialog(body, crate_file)
		check_animator()
	pass # Replace with function body.

func check_animator():
	if got_apple and not got_crate:
		$AnimationPlayer.play("Idle")
	elif got_apple and got_crate:
		$AnimationPlayer.play("Idle2")
	pass

func trigger_dialog(body, dialog_file):
	GameController.yes_no_ui.set_who_is_talking_with(self)
	body.queue_free()
	var myTrigger = Utils.instance_scene_on_main(DialogTrigger, global_position)
	myTrigger.set_dialog_path(dialog_file, npc_name)

func get_answer(my_choose):
	if my_choose and got_crate:
		GameController.story_controller.story_result[1] = 3
		$AnimationPlayer.play("Sing2")
	if my_choose and not got_crate:
		GameController.story_controller.story_result[1] = 1
		$AnimationPlayer.play("Sing")

func to_idle(state):
	if state:
		$AnimationPlayer.play("Idle2")
	else:
		$AnimationPlayer.play("Idle")
	pass
