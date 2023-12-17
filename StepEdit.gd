class_name StepEdit
extends CodeEdit

@export var cols = [3,2,2,5,5,5]

# Called when the node enters the scene tree for the first time.
func _ready():
	for col in cols:
		for i in col:
			text += "-"
		if col != len(cols) - 1: text += " "
	
	theme = load("res://trakatron_theme.tres")
	set_caret_type(TextEdit.CARET_TYPE_BLOCK)
	set_custom_minimum_size(Vector2(get_line_width(0) + 10, get_line_height() + 10))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			#KEY_ENTER: _ignoreEvent()
			KEY_TAB: 
				set_caret_column(10)
				jumpToNextColumn()
				_ignoreEvent()
		pass
		

## Disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
func _ignoreEvent():
	get_parent().get_parent().get_parent().set_input_as_handled()

func jumpToNextColumn():
	var nextCol := text.find(" ")
	set_caret_column(nextCol)

func removeNextChar():
	var pos := get_caret_column()
	set_caret_column(pos+1)
	backspace()
