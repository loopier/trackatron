class_name TrackerEdit
extends CodeEdit

var Hex = preload("res://Hex.gd")

enum Mode {
	NORMAL,
	INPUT,
	VISUAL,
}
var activeMode := Mode.NORMAL

## represents an instrument parameter grid
class TrackInstrument:
	var id := Hex.withDefault(0,2)
	var voice1 := TrackVoice.new()
	
	func asString() -> String:
		var str := "INST %s\n" % [id.value]
		str += "%sF" % []
		str += "V1\t%s\t" % [voice1.asString()]
		return str

class TrackVoice:
	var wave := Hex.withDefault(0,1)
	var filterCutoff := Hex.withDefault(64)
	
	func _init():
		# TODO: add header here?
		wave.set_header("W")
		filterCutoff.set_header("")
	
	func asString() -> String:
		var str := "%s %s" % [wave.value, filterCutoff.value]
		return str

var ins := TrackInstrument.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var width : int = get_parent().get_parent().get_viewport_rect().size.x
	var height : int = get_parent().get_parent().get_viewport_rect().size.y
	set_custom_minimum_size(Vector2(width, height))
	
	text = "%s" % [ins.asString()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_caret_column() < 2: set_caret_column(2)
	pass

func _input(event):
	match activeMode:
		Mode.NORMAL: _normalModeInput(event)

func _normalModeInput(event):
	if Input.is_action_pressed("increment_number"):
		incrementValue()
		_ignoreEvent()
	if event is InputEventKey and event.pressed:
		#deselect()
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
		#selectSlot()

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().get_parent().get_parent().set_input_as_handled()

func _simulateKeyPress(key: Key):
	Log.debug(key)
	var ev = InputEventKey.new()
	ev.keycode = key
	_input(ev)

func insertText(str: String):
	# FIX: replace with start_action(ACTION_DELETE)?
	var lnText = get_line(get_caret_line()).substr(get_caret_column())
	if isEOC(): nextColumn()
	if isEOL(): set_caret_column(get_caret_column() - 1)
	remove_text(get_caret_line(), get_caret_column(), get_caret_line(), get_caret_column() + 1)
	insert_text_at_caret(str)
	set_caret_column(get_caret_column() - 1)

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

func selectSlot():
	var ln := get_caret_line()
	var cl := get_caret_column()
	var lnText := get_line(ln)
	var prev := lnText.rfind(" ", cl) + 1
	var next := lnText.find(" ", cl)
	if next < 0: next = len(lnText)
	Log.debug("%s (%s) %s - %s" % [prev, cl, next, lnText.find(" ")])
	select(ln, prev, ln, next)

func incrementValue():
	var original = get_line(get_caret_line()).substr(get_caret_column(),1)
	var value = original.hex_to_int()
	var inc = value + 1
	var hex = "%X" % inc
	Log.debug("%s:%s %s:%s" % [original, value, inc, hex])
	insert_text_at_caret(hex)
	set_caret_column(get_caret_column() - 1)
