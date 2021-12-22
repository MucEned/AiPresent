extends StaticBody2D

var today = OS.get_datetime()

func _ready():
	if today.day == 25 and today.month == 12:
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
