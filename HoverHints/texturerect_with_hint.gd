extends TextureRect
class_name TextureRectWithHint, "res://addons/HoverHints/Icons/icon.png"

export (String, MULTILINE)  var Hint_Text 
export (bool) var Stick_to_viewport_boards := true
export (Vector2) var additional_offset

export var Hint = preload("res://addons/HoverHints/Scenes/Hint.tscn")
var hint_current 

var timer = Timer.new()

func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			HideHint()

func _ready():
	add_child(timer)
	timer.wait_time= 5
	timer.one_shot = true
	connect("mouse_entered",self,"ShowHint")
	connect("mouse_exited",self,"HideHint")
	timer.connect("timeout",self,"HideHint")

func ShowHint():
	timer.start()
	var h = Hint.instance()
	h.offset = additional_offset
	h.sticktoviewportlimits = Stick_to_viewport_boards
	h.text = Hint_Text
	hint_current = h
	h.set_as_toplevel(true)
	add_child(h)

func HideHint():
	if hint_current:
		hint_current.queue_free()
		hint_current = null
