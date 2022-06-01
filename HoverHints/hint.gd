extends Control

var text := ""
var sticktoviewportlimits = true

onready var TextLabel = $"Panel/Label"
onready var TextPanel = $"Panel"

export var offset = Vector2()

func _ready():
	#Change Text
	TextLabel.text = text


func _process(delta):
	#Follow cursor
	var mouse_pos = get_global_mouse_position()
	#Offset
	rect_position = mouse_pos - (Vector2(0,TextLabel.rect_size.y) + offset)
	#Rect Size
	TextPanel.rect_size = TextLabel.rect_size
	#Clamp rect_position
	if sticktoviewportlimits:
		rect_position.y = clamp(rect_position.y,0,get_viewport_rect().size.y - TextPanel.rect_size.y)
		rect_position.x = clamp(rect_position.x,0,get_viewport_rect().size.x - TextPanel.rect_size.x)
