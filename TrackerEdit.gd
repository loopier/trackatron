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
		text += "\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_RIGHT: moveRight()
			KEY_LEFT: moveLeft()
			KEY_ENTER: 
				Log.warn("<ENTER> key is disabled in `TrackerEdit.gd`")
				_ignoreEvent()

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().get_parent().get_parent().set_input_as_handled()

func moveRight():
	var ln := get_caret_line()
	var lineText := get_line(ln)
	var pos := lineText.find(" ", get_caret_column())
	set_caret_column(pos)
	select(ln, pos, ln, lineText.find(" ", pos))

func moveLeft():
	# moving backwards goes to the end of the previous word so
	# we need to move back twice then move forward once
	var ln := get_caret_line()
	var lineText := get_line(ln)
	var pos := get_caret_column()
	pos = lineText.rfind(" ", get_caret_column())
	set_caret_column(pos)
	pos = lineText.rfind(" ", get_caret_column())
	set_caret_column(pos)
	#moveRight()

func moveUp():
	pass

func moveDown():
	pass
