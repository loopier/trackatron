extends CodeEdit

signal msg_evaluated(addr, args)

# Called when the node enters the scene tree for the first time.
func _ready():
	var width : int = get_parent().get_parent().get_viewport_rect().size.x
	set_custom_minimum_size(Vector2(width, get_line_height() + 10))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_ENTER: 
				_ignoreEvent()
				evalMsg()

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().get_parent().get_parent().set_input_as_handled()

func evalMsg():
	var items := text.split(" ")
	var addr = items[0]
	var args := []
	for item in items.slice(1):
		args.append(item)
		Log.verbose("%s:%s" % [item, typeof(item)])
	msg_evaluated.emit(addr, args)
