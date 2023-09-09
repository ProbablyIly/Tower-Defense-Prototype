extends VBoxContainer


func _ready():
	visible = false


func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("debug"):
		if visible == true:
			visible = false
		else:
			visible = true
			
func _on_kill_enemies_pressed():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.queue_free()

func _on_button_pressed():
	global.Currency += $SplitContainer/SpinBox.value


func _on_free_upgrades_pressed():
	$"../Sidebar/Editor".bought.emit()
	

func _on_curve_pressed():
	var curve = load("res://misc/EditorPrices.tres")
	$HBoxContainer/Label.text = str(snapped(curve.sample($HBoxContainer/SpinBox.value/50),1))


func _on_enemy_pressed():
	spawner.spawn_enemy($HBoxContainer2/SpinBox.value)


func _on_start_round_pressed():
	spawner.start_round()
