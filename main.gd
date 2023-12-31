extends Node2D
class_name Main

var osc: OscReceiver
var soundServerOscIp := "127.0.0.1"
var soundServerOscPort := 4001
var Zyn = preload("res://Zyn.gd")
var StepEdit = preload("res://StepEdit.gd")
var Routine = preload("res://routine.tscn")
var stepsPerPhrase = 16
## Placehoder for an OSC message.
## ZynAddSubFX OSC API uses very long and complex messages. We want to edit parts
## without having to write everything.
var msgBuf := ""

@onready var sequencer : Routine
@onready var lastNote : int

# Called when the node enters the scene tree for the first time.
func _ready():
	Log.setLevel(Log.LOG_LEVEL_VERBOSE)
	osc = OscReceiver.new()
	self.add_child.call_deferred(osc)
	osc.startServer()
	var children = get_children()
	#OS.execute("zynaddsubfx", ["-P", soundServerOscPort])
	sequencer = Routine.instantiate()
	sequencer.name = "sequencer"
	sequencer.wait_time = 0.25
	add_child(sequencer)
	sequencer.timeout.connect(_on_sequencer_timeout)
	#sequencer.start()
	
	$VBoxContainer/Prompt.msg_evaluated.connect(_on_msg_evaluated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if not event is InputEventKey: return
	if event.pressed:
		match event.keycode:
			KEY_ESCAPE: sendOsc("/Panic", [])
			KEY_SPACE:
				#sendOsc("/noteOn", [0, 60, randi() % 96 + 12])
				pass
			KEY_TAB:
				#focusNext()
				_ignoreEvent()
	#if event.is_released():
		#match event.keycode:
			#KEY_SPACE:
				#sendOsc("/noteOff", [0, 60])

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


func _on_sequencer_timeout():
	#sendOsc("/noteOn", [0, randi() % 127 , 60])
	#Log.debug("timer: %s" % [sequencer.tick])
	if sequencer.tick % 2: 
		lastNote =  randi() % 72 + 36
		sendOsc("/noteOn", [0, lastNote, randi() % 64 + 36])
	else: sendOsc("/noteOff", [0, lastNote])
	pass

func _on_msg_evaluated(addr: String, args: Array):
	Log.verbose("OSC msg: %s %s" % [addr, args])
	#Log.verbose("types %s: %s" % [addr, zynTypes[addr]])
	var parsedArgs := []
	var types = getMsgArgTypes(addr)
	args.resize(len(types))
	for i in len(args):
		match types[i]:
			"i": parsedArgs.append(int(args[i]))
			"f", "d": parsedArgs.append(float(args[i]))
			"B": parsedArgs.append(bool(int(args[i])))
			"s": parsedArgs.append(args[i])
			_: pass
	for arg in parsedArgs:
		Log.verbose("types %s:%s" % [arg, typeof(arg)])
	sendOsc(addr, parsedArgs)

func getMsgArgTypes(addr: String) -> Array:
	# OSC messages my have indices in the address, so we need to replace the 
	# actual number in the written message with the tag used in the dictionary key.
	# Maybe we could use wildcard matching?
	var regex := RegEx.new()
	regex.compile("\\d")
	var result = regex.search(addr)
	if result: addr = addr.replace(result.get_string(), "#")
	if Zyn.osc[addr]:
		return Zyn.osc[addr].split()
	else:
		return []

func parseCommand(cmd: String) -> String:
	var items = cmd.split()
	var osc = Zyn.commands[items[0]]
	var arg = items[1]
	var argIndex = msgBuf.find(osc)
	msgBuf = "%s%s" % [osc, arg]
	return msgBuf
