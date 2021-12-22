extends TextureRect

onready var timer = $Timer
onready var text = $Text

export var story_path = ""
export (float) var text_speed = 0.05

var story

var phrase_num = 0
var finished = false

func _ready():
	GameController.story_box = self
	timer.wait_time = text_speed
	#set_story(story_path)

func set_story(new_story_path):
	story_path = new_story_path
	story = get_story()
	assert(story, "story not found")
	next_phrase()
	
func get_story():
	phrase_num = 0;
	var f = File.new()
	assert(f.file_exists(story_path), "File path does not exist")

	f.open(story_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	visible = true
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
	

func next_phrase():
	if phrase_num >= len(story):
		visible = false
		return
	
	finished = false

	text.bbcode_text = story[phrase_num]["Text"]
	
	text.visible_characters = 0
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
		
	finished = true
	phrase_num += 1
	return

func next_trigger():
	#if finished:
	next_phrase()
	#else:
		#text.visible_characters = len(text.text)
