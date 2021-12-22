extends ColorRect

onready var timer = $Timer
onready var speaker_name = $Name
onready var text = $Text

export var dialog_path = ""
export (float) var text_speed = 0.05

var dialog

var phrase_num = 0
var finished = false

func _ready():
	GameController.dialog_box = self
	timer.wait_time = text_speed
	set_dialog(dialog_path)

func set_dialog(new_dialog_path):
	dialog_path = new_dialog_path
	dialog = get_dialog()
	assert(dialog, "Dialog not found")
	next_phrase()

func _process(delta):
	if visible:
		GameController.speaking = true
	else:
		GameController.speaking = false
		
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			next_phrase()
		else:
			text.visible_characters = len(text.text)
	
func get_dialog():
	phrase_num = 0;
	var f = File.new()
	assert(f.file_exists(dialog_path), "File path does not exist")

	f.open(dialog_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	visible = true
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
	

func next_phrase():
	if phrase_num >= len(dialog):
		visible = false
		return
	
	finished = false

	if dialog[phrase_num]["Name"] == "Ened":
		trigger_Yes_No_UI(dialog[phrase_num]["Text"])
		finished = true
		phrase_num += 1
		next_phrase()
		return

	speaker_name.bbcode_text = dialog[phrase_num]["Name"]
	text.bbcode_text = dialog[phrase_num]["Text"]
	
	text.visible_characters = 0
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
		
	finished = true
	phrase_num += 1
	return

func trigger_Yes_No_UI(text):
	var YNUI = get_parent().get_child(3)
	YNUI.show_yes_no()
	YNUI.set_question(text)
	pass
