class_name TrackerEdit
extends CodeEdit

var cols = [3,2,2,5,5,5]
var rows = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	var width : int = get_parent().get_parent().get_viewport_rect().size.x
	var height : int = get_parent().get_parent().get_viewport_rect().size.y
	set_custom_minimum_size(Vector2(width, height))
	
	for ln in rows:
		text += "%X " % [ln]
		for col in cols:
			for i in col:
				text += "-"
			text += " "
		text = text.substr(0, len(text)-1)
		text += "\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_caret_column() < 2: set_caret_column(2)
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_TAB: 
				nextColumn()
				_ignoreEvent()
			#KEY_RIGHT: nextColumn()
			#KEY_LEFT: prevColumn()
			KEY_SPACE: 
				nextColumn()
				_ignoreEvent()
			KEY_ENTER:
				Log.warn("<ENTER> key is disabled in `TrackerEdit.gd`")
				_ignoreEvent()
			_:
				if event.keycode >= KEY_A and event.keycode <= KEY_Z:
					insertText(event.as_text())
					_ignoreEvent()

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().get_parent().get_parent().set_input_as_handled()

func insertText(str: String):
	var lnText = get_line(get_caret_line()).substr(get_caret_column())
	if isEOC(): nextColumn()
	if isEOL(): set_caret_column(get_caret_column() - 1)
	remove_text(get_caret_line(), get_caret_column(), get_caret_line(), get_caret_column() + 1)
	insert_text_at_caret(str)

## Is end of column
func isEOL() -> bool:
	var ln := get_caret_line()
	var lineText := get_line(ln)
	var next = get_line(get_caret_line()).substr(get_caret_column(),1)
	return next.unicode_at(0) == 0

## Is end of column
func isEOC() -> bool:
	var ln := get_caret_line()
	var lineText := get_line(ln)
	var next = get_line(get_caret_line()).substr(get_caret_column(),1)
	return next == " "

func nextColumn():
	if isEOC:
		set_caret_column(get_caret_column() + 1)
		return
	var ln := get_line(get_caret_line())
	var pos := ln.find(" ", get_caret_column())
	set_caret_column(pos)

func prevColumn():
	var ln := get_caret_line()
	var lineText := get_line(ln)
	var pos := get_caret_column()
	pos = lineText.rfind(" ", get_caret_column())
	set_caret_column(pos)
