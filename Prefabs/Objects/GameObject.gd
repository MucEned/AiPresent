extends KinematicBody2D

var motion = Vector2.ZERO
var selected = false
var picked = false
var stucked = false

export (int) var GRAVITY = 512
export (int) var TYPE = 0
#0: crate, 1: redapple, 2: greenapple

func _ready():
	pass # Replace with function body.

func _process(delta):
	if selected:
		followMouse()
	elif not stucked or not is_on_floor():
		add_gravity(delta)
		motion = move_and_slide(motion, Vector2.UP)
	
func followMouse():
	global_position = get_global_mouse_position()
	pass

func add_gravity(delta):
	motion.y += GRAVITY * delta

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			selected = true
		else:
			selected = false

func _on_Area2D_area_entered(area):
	stucked = true;

func _on_Area2D_area_exited(area):
	stucked = false;

func picking():
	queue_free()
	pass
