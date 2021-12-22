extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	GameController.transition_box.play_gift()
	$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Final.tscn")
	pass # Replace with function body.
