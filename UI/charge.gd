extends ProgressBar

func _process(delta):
	pass

func _on_timer_timeout():
	if global.charge <= 60:
		update_charge(2)
		
func update_charge(n):
		var tween = create_tween()
		global.charge += n
		tween.tween_property(self, "value", global.charge, $Timer.wait_time)
		
		
	
	

