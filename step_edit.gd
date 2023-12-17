extends CodeEdit

@export var maxLength := 3

# Called when the node enters the scene tree for the first time.
func _ready():
	set_custom_minimum_size(Vector2(16 * (maxLength + 1), get_line_height()))
	for i in range(maxLength):
		set_text("%s " % [get_text()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		_maxText()
		#match event.keycode:
			#KEY_ENTER: _ignoreEvent()
			#KEY_TAB: _ignoreEvent()
			

func _maxText():
	if get_caret_column() >= maxLength:
		set_text(get_text().substr(0, maxLength-1))
		set_caret_column(maxLength)

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().get_parent().get_parent().set_input_as_handled()
