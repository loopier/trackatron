extends Timer
class_name Routine

var tick = 0

func _ready():
	Log.debug("timer %s: %s" % [name, wait_time])
	timeout.connect(_on_timeout)

func _on_timeout():
	tick = tick + 1
