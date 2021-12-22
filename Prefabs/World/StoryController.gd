extends Node

var story1_result = 0 #0,1,2,3
#0 -> Ai di qua luon
#1 -> Ai cho tao
#2 -> Ai quet don
#3 -> Ai quet + cho tao
var story2_result = 0 #0,1,2,3
#0 -> Ai di qua luon
#1 -> Nghe hat
#2 -> Cho crate, khong nghe hat
#3 -> Cho crate + nghe hat
var story3_result = 0 #0,1,2
#0 -> di qua luon
#1 -> cho tao + khong dap qua 3 cay
#2 -> cho tao + dap qua 3 cay
#3 -> khong cho tao + dap qua 3 cay
var	 story_result = [0, 0, 0]

var seed_i_destroyed = 0

func _ready():
	GameController.story_controller = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
