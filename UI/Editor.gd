extends VBoxContainer

@onready var rangebox =  $RangeContainer/RangeBox

var LastSelection
var apply = false

var old_range

# Called when the node enters the scene tree for the first time.
func _ready():
	LastSelection = global.CurrentSelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.CurrentSelection != LastSelection:
		editor_update()
		old_range = global.CurrentSelection.range
		LastSelection = global.CurrentSelection


func _update_editor():
	pass

func _on_range_box_value_changed(value):
	global.CurrentSelection.range = rangebox.value * 10
	
	
	
func editor_update():
	rangebox.value = global.CurrentSelection.range / 10
	if LastSelection != null:
		if apply == false:
			LastSelection.range = old_range
			
		apply = false


func _on_button_pressed():
	apply = true
