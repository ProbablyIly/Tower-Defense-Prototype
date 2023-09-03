extends ProgressBar

func _process(delta):
	value = global.charge 


func _on_timer_timeout():
	if global.charge <= 60:
		var tween = create_tween()
		global.charge += 10
		tween.tween_property(self, "value", global.charge, 1)

