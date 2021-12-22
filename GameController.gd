extends Node

var hunger_point = 100
var player
var dialog_box
var story_box
var transition_box
var story_controller
var yes_no_ui
var speaking = false

signal playerHungry()
signal playerNormal()

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
