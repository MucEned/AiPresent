extends Area2D

var default_path_header = "res://Dialogs/Story"
export var story_path = ""
export var story_order = 0

var was_trigger = false

func _ready():
	pass # Replace with function body.

func load_story_script():
	var story_result = GameController.story_controller.story_result[story_order]
	story_path = default_path_header + String(story_order + 1) + "/" + String(story_result) + "/telling.json"
	return  story_path

func _on_StoryTrigger_body_entered(body):
	if not was_trigger and GameController.story_box.visible == false:
		was_trigger = true
		GameController.story_box.visible = true
		GameController.story_box.set_story(load_story_script())
	else:
		GameController.story_box.next_trigger()
	queue_free()
