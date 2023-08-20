extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_sidebar()


func _input(event):
	pass

func _update_sidebar():
	if global.CurrentSelection != null:
		$Inspector/HealthContainer/HealthBox.text = str(global.CurrentSelection.hp.value) + "/" + str(global.CurrentSelection.hp.max_value)
		
		var current_time = Time.get_ticks_msec() / 1000.0
		var seconds = abs(round(current_time - global.CurrentSelection.creationTime - 60*global.CurrentSelection.mins))
		if seconds == 60:
			global.CurrentSelection.minutes += 1
			global.CurrentSelection.mins += 1
		if global.CurrentSelection.minutes == 60:
			global.CurrentSelection.minutes -= 60
			global.CurrentSelection.hours += 1
		
		$Inspector/TimeContainer/TimeBox.text = str(seconds) + "s " + str(global.CurrentSelection.minutes) + "m " + str(global.CurrentSelection.hours) + "h"
