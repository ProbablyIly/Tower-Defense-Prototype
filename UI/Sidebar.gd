extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
		$Inspector/DPSContainer.visible = false
		$Inspector/KilledContainer.visible = false
		$Inspector/CooldownContainer.visible = false
		$Inspector/HealthContainer.visible = false
		$Inspector/TimeContainer.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_sidebar()


func _input(event):
	pass

func _update_sidebar():
	if global.CurrentSelection != null:
		
		if "damage" in global.CurrentSelection: 
			$Inspector/DPSContainer.visible = true
			$Inspector/DPSContainer/DPSBox.text = str(snapped(global.CurrentSelection.damage/global.CurrentSelection.cooldown, 0.01)) + "/s"
		else:
			$Inspector/DPSContainer/DPSBox.text = "null"
			$Inspector/DPSContainer.visible = false
			
		
		if global.CurrentSelection.killed != null: 
			$Inspector/KilledContainer.visible = true
			$Inspector/KilledContainer/KilledBox.text = str(global.CurrentSelection.killed)
		else:
			$Inspector/KilledContainer/KilledBox.text = "null"
			$Inspector/KilledContainer.visible = false
		
		if "cooldown" in global.CurrentSelection: 
			$Inspector/CooldownContainer.visible = true
			$Inspector/CooldownContainer/CoolBox.text = str(snapped(global.CurrentSelection.timer.time_left, 0.1)) + "s"
		else:
			$Inspector/CooldownContainer/CoolBox.text = "null"
			$Inspector/CooldownContainer.visible = false
		
		$Inspector/HealthContainer.visible = true
		$Inspector/HealthContainer/HealthBox.text = str(global.CurrentSelection.hp.value) + "/" + str(global.CurrentSelection.hp.max_value)
		
		var current_time = Time.get_ticks_msec() / 1000.0
		var seconds = abs(round(current_time - global.CurrentSelection.creationTime - 60*global.CurrentSelection.mins))
		if seconds == 60:
			global.CurrentSelection.minutes += 1
			global.CurrentSelection.mins += 1
		if global.CurrentSelection.minutes == 60:
			global.CurrentSelection.minutes -= 60
			global.CurrentSelection.hours += 1
		
		$Inspector/TimeContainer.visible = true
		$Inspector/TimeContainer/TimeBox.text = str(seconds) + "s " + str(global.CurrentSelection.minutes) + "m " + str(global.CurrentSelection.hours) + "h"
	if global.CurrentSelection == null:
		$Inspector/DPSContainer/DPSBox.text = "null"
		$Inspector/KilledContainer/KilledBox.text = "null"
		$Inspector/CooldownContainer/CoolBox.text = "null"
		$Inspector/HealthContainer/HealthBox.text = "null"
		$Inspector/TimeContainer/TimeBox.text = "null"
		
		$Inspector/DPSContainer.visible = false
		$Inspector/KilledContainer.visible = false
		$Inspector/CooldownContainer.visible = false
		$Inspector/HealthContainer.visible = false
		$Inspector/TimeContainer.visible = false
		
