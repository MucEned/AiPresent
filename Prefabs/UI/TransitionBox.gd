extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.transition_box = self
	pass # Replace with function body.

func play_out():
	$AnimationPlayer.play("Out")
	pass

func play_gift():
	$AnimationPlayer.play("Gift")
	pass
	

func go_to(scene):
	if scene == 0:
		get_tree().change_scene("res://Prefabs/UI/Troll.tscn")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
