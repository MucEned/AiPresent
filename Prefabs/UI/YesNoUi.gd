extends TextureRect

var my_choose = false
var npc
var was_trigger = false
var holding = false

onready var Abutton = $TextureRect
onready var Dbutton = $TextureRect2

export (Material) var button_material

func _ready():
	GameController.yes_no_ui = self
	change_button_choosing(my_choose)
	
func _process(delta):
	if visible:
		if Input.is_action_just_pressed("ui_left"):
			my_choose = false
			change_button_choosing(false)
		if Input.is_action_just_pressed("ui_right"):
			my_choose = true
			change_button_choosing(true)
		if not was_trigger:
			was_trigger = true
			$Timer.start()
		if Input.is_action_just_pressed("ui_accept") and holding:
			accept(my_choose, npc)
	pass

func show_yes_no():
	visible = true

func change_button_choosing(option):
	if option:
		Dbutton.material = button_material
		Abutton.material = null
		pass
	else:
		Abutton.material = button_material
		Dbutton.material = null
		pass
	pass

func accept(my_choose, who):
	visible = false
	holding = false
	was_trigger = false
	who.get_answer(my_choose)
	pass

func set_who_is_talking_with(who):
	npc = who
	pass

func set_question(text):
	$RichTextLabel.bbcode_text = text

func _on_Timer_timeout():
	holding = true
	pass # Replace with function body.
