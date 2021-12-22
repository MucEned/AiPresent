extends KinematicBody2D

const JumpEffect = preload("res://Prefabs/Effects/JumpEffect.tscn")

onready var sprite = $Sprite
onready var animator = $Animator
onready var hand = $RayCast2D
onready var dropPoint = $Sprite/DropPoint

export (int) var MAX_SPEED = 100
export (int) var HUNGER_SPEED = 60
export (int) var A = 512
export (float) var FRICTION = 0.3
export (int) var GRAVITY = 512
export (int) var JUMP_FORCE = 164
export (int) var MAX_SLOPE_ANGLE = 45
export (int) var SLOPE_MAX_THRESHOLD = 64

var current_speed = MAX_SPEED
var motion = Vector2.ZERO
var snap_vector = Vector2.ZERO
var just_jump = false
var holding = false
var item_holding = -1;

var is_hungry = false;
var is_actioning = false;

func _ready():
	GameController.player = self
	pass # Replace with function body.

func _physics_process(delta):
	just_jump = false
	var input_vector_x = 0
	input_vector_x = get_x_direction_input_vector()
	x_direction_calculate(input_vector_x, delta)
	add_gravity(delta)
	update_snap_vector()
	jump_input_check()
	update_use_check()
	update_pick_check()
	update_animation(input_vector_x)
	move(input_vector_x)
	update_hunger_point_check()
	update_rope_check()

func get_x_direction_input_vector():
	if not GameController.speaking:
		return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	else:
		return 0

func add_gravity(delta):
	motion.y += GRAVITY * delta

func move(input_vector_x):
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	var last_motion = motion
	var last_position = position
	if input_vector_x == 0 && abs(motion.x) < SLOPE_MAX_THRESHOLD:
		motion.x = 0
	var stop_on_slope = true if get_floor_velocity().x == 0 else false
	motion = move_and_slide_with_snap(motion, snap_vector * 6, Vector2.UP, stop_on_slope, 4, deg2rad(MAX_SLOPE_ANGLE))
	#Landing
	if was_in_air and is_on_floor():
		Utils.instance_scene_on_main(JumpEffect, global_position)
		motion.x = last_motion.x
		
	#Just left ground
	if was_on_floor and not is_on_floor() and not just_jump: #just jump in frame
		motion.y = 0;
		position.y = last_position.y
		
	#Prevent Sliding
	#if is_on_floor() and get_floor_velocity().length() == 0 and abs(motion.x) < 1:
	#	position.x = last_position.x 

func x_direction_calculate(input_vector_x, delta):
	motion.x += input_vector_x * A * delta
	motion.x = clamp(motion.x, -current_speed, current_speed)
	if input_vector_x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)
		
	if input_vector_x != 0:
		sprite.scale.x = sign(input_vector_x)
		hand.cast_to.x = sign(input_vector_x) * 10.0

func jump_input_check():
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and not GameController.speaking:
		#Utils.instance_scene_on_main(JumpEffect, self.global_position)
		Utils.instance_scene_on_main(JumpEffect, global_position)
		just_jump = true
		motion.y -= JUMP_FORCE
		snap_vector = Vector2.ZERO
		
func update_snap_vector():
	if is_on_floor():
		snap_vector = Vector2.DOWN

func update_animation(input_vector_x):
	if not is_actioning:
		if input_vector_x != 0:
			animator.play("Move")
		else:
			animator.play("Idle")
			
		if not is_on_floor():
			if motion.y >= 50:
				animator.play("JumpDown")
			elif motion.y < 50 and motion.y > -50:
				animator.play("JumpMiddle")
			else:
				animator.play("JumpUp")

func update_pick_check():
	if Input.is_action_just_pressed("pick"):
		is_actioning = true;
		animator.play("Action")
		if holding:
			drop()
		else:
			if hand.get_collider():
				var object = hand.get_collider()
				object.picking()
				holding = true
				item_holding = object.TYPE

func update_use_check():
	if Input.is_action_just_pressed("use") and item_holding > 0:
		if item_holding == 1:
			add_hunger_point(20)
		if item_holding == 2:
			add_hunger_point(10)
		if item_holding == 3:
			is_actioning = true;
			animator.play("Action")
		if item_holding < 3:
			item_holding = 0
			holding = false

func update_hunger_point_check():
	if GameController.hunger_point <= 0 and is_hungry == false:
		GameController.emit_signal("playerHungry")
		is_hungry = true
		current_speed = HUNGER_SPEED
	elif GameController.hunger_point > 0 and is_hungry == true:
		GameController.emit_signal("playerNormal")
		is_hungry = false
		current_speed = MAX_SPEED
	
func drop():
	Utils.instance_scene_on_main(Bag.array[item_holding], dropPoint.global_position)
	item_holding = 0
	holding = false
	pass

func _on_HungerCounter_timeout():
	add_hunger_point(-1)
	pass # Replace with function body.

func add_hunger_point(point):
	GameController.hunger_point += point
	GameController.hunger_point = clamp(GameController.hunger_point, 0, 100);

func return_idle():
	is_actioning = false;

func sweep():
	if item_holding == 3:
		$Sprite/Area2D/CollisionShape2D.disabled = false
		
func update_rope_check():
	if $RopeCheck.is_colliding() and is_on_floor():
		if Input.is_action_just_pressed("ui_down"):
			position.y += 4; 
			
func moving_platform_check(input_vector_x):
	if input_vector_x == 0 && abs(motion.x) < SLOPE_MAX_THRESHOLD:
		motion.x = 0


func _on_GroundCheck_body_entered(body):
	$InGround.wait_time = 1
	$InGround.start()
	pass # Replace with function body.

func _on_GroundCheck_body_exited(body):
	$InGround.stop()
	pass # Replace with function body.

func _on_InGround_timeout():
	gone()
	pass # Replace with function body.

func gone():
	GameController.transition_box.play_out()
	pass
