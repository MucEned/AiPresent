extends Area2D

export var dialog_path = "res://Dialogs/Dial/"
export var npc_name = ""
export var dialog_file = ""

func _ready():
	pass # Replace with function body.

func _on_DialogTrigger_body_entered(body):
	GameController.dialog_box.visible = true
	GameController.dialog_box.set_dialog(load_dialog_script())
	queue_free()
	pass # Replace with function body.

func set_dialog_path(file, npc):
	npc_name = npc
	dialog_file = file

func load_dialog_script():
	return dialog_path + npc_name + "/" + dialog_file + ".json"
