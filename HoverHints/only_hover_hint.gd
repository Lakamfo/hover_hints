extends Control
class_name HoverHint, "res://addons/HoverHints/Icons/iconHint.png"

export(String, MULTILINE) var Hint_Text
export (bool) var Stick_to_viewport_boards := true
export (Vector2) var additional_offset
export (NodePath) var ControlOrArea

var hint_current 
var object

var timer = Timer.new()

export var Hint = preload("res://addons/HoverHints/Scenes/Hint.tscn")


func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			HideHint()


func _ready():
	set_physics_process(false)
	add_child(timer)
	timer.wait_time= 5
	timer.one_shot = true
	if ControlOrArea:
		object = get_node(ControlOrArea)
		object.connect("mouse_entered",self,"ShowHint")
		object.connect("mouse_exited",self,"HideHint")
		timer.connect("timeout",self,"HideHint")


func ShowHint():
	timer.start()
	var h = Hint.instance()
	h.text = Hint_Text
	h.sticktoviewportlimits = Stick_to_viewport_boards
	h.offset = additional_offset
	hint_current = h
	h.set_as_toplevel(true)
	add_child(h)


func HideHint():
	if hint_current:
		hint_current.queue_free()
		hint_current = null
