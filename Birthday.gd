extends Area2D

func _on_Birthday_body_entered(body):
	GameController.transition_box.play_gift()
	$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	get_tree().change_scene("res://Gift/Letter.tscn")
	pass # Replace with function body.
