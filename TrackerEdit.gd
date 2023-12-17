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
		text = "%s " % [ln]
		for col in cols:
			for i in col:
				text += "-"
			text += " "

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
