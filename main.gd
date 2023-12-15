extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_TAB:
				focusNext()
				_ignoreEvent()

func sendOsc(msg: String):
	print("Send OSC: %s" % [msg])

func focusNext():
	var viewport = get_parent().get_viewport()
	var focused = viewport.gui_get_focus_owner()
	var parent = focused.get_parent()
	var index = focused.get_index() + 1 % parent.get_child_count()
	var next = parent.get_child(index)
	next.grab_focus()
	print("TODO main.focusNext")

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().set_input_as_handled()
