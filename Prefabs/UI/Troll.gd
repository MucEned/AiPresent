extends Control

func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	get_tree().change_scene("res://Prefabs/World/World.tscn")
	pass # Replace with function body.
