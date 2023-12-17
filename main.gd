extends Node2D

var osc: OscReceiver
var soundServerOscIp := "127.0.0.1"
var soundServerOscPort := 4001

# Called when the node enters the scene tree for the first time.
func _ready():
	Log.setLevel(Log.LOG_LEVEL_VERBOSE)
	osc = OscReceiver.new()
	self.add_child.call_deferred(osc)
	osc.startServer()
	#OS.execute("zynaddsubfx", ["-P", soundServerOscPort])
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if not event is InputEventKey: return
	if event.pressed:
		match event.keycode:
			KEY_SPACE:
				sendOsc("/noteOn", [0, 60, randi() % 96 + 12])
			KEY_TAB:
				focusNext()
				_ignoreEvent()
	if event.is_released():
		match event.keycode:
			KEY_SPACE:
				sendOsc("/noteOff", [0, 60])

func sendOsc(addr: String, args: Array):
	#Log.verbose("%s %s" % [addr, args])
	osc.sendMessage("%s/%s" % [soundServerOscIp, soundServerOscPort], addr, args)

func focusNext():
	var viewport = get_parent().get_viewport()
	var focused = viewport.gui_get_focus_owner()
	var parent = focused.get_parent()
	var index = focused.get_index() + 1 % (parent.get_child_count())
	var next = parent.get_child(index)
	next.grab_focus()
	print("TODO main.focusNext")

func _ignoreEvent():
	# disable the event at the Window level, the hierarchy is (Window.Main.TextEdit.self)
	get_parent().set_input_as_handled()


func _on_timer_timeout():
	#sendOsc("/noteOn", [0, randi() % 127 , 60])
	pass
