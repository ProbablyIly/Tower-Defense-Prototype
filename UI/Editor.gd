extends VBoxContainer

@onready var damagebox = $DamageContainer/DamageBox
@onready var rangebox =  $RangeContainer/RangeBox
@onready var healthbox = $HealthContainer/Healthbox
@onready var coolbox = $CooldownContainer/CooldownBox
@onready var chargebox = $ChargeContainer/ChargeBox

signal bought
var isbought = false


var LastSelection
var apply = false

var old_dmg
var old_range
var old_hp
var old_cooldown
var old_charge

var dmg_diff = 0
var range_diff = 0
var hp_diff = 0
var cooldown_diff = 0
var charge_diff = 0

var price = 0

var dmg_mul = 5
var range_mul = 10
var hp_mul = 10
var cooldown_mul = 5
var charge_mul

var changed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	LastSelection = global.CurrentSelection
	$RangeContainer.visible = false
	$DamageContainer.visible = false
	$HealthContainer.visible = false
	$CooldownContainer.visible = false
	$ChargeContainer.visible = false
	$HBoxContainer/Button.visible = false
	
	
func _process(delta):
	if global.CurrentSelection != LastSelection:
		editor_update()
		
		if global.CurrentSelection != null:
			if "damage" in global.CurrentSelection:
				old_dmg = global.CurrentSelection.damage
			if "range" in global.CurrentSelection:
				old_range = global.CurrentSelection.range
			if "hp_val" in global.CurrentSelection:
				old_hp = global.CurrentSelection.hp_val
			if "cooldown" in global.CurrentSelection:
				old_cooldown = global.CurrentSelection.cooldown
			if "charge" in global.CurrentSelection:
				old_charge = global.CurrentSelection.charge
			
		LastSelection = global.CurrentSelection
			
	
	if changed:	
		check_price()
		changed = false

func editor_update():
	
	if global.CurrentSelection != null:
		if "range" in global.CurrentSelection:
			$RangeContainer.visible = true
			rangebox.value = (global.CurrentSelection.range-100) / range_mul
		else:
			$RangeContainer.visible = false
	
		if "damage" in global.CurrentSelection:
			$DamageContainer.visible = true
			damagebox.value = global.CurrentSelection.damage / dmg_mul
		else:
			$DamageContainer.visible = false
		
		if "hp_val" in global.CurrentSelection:
			$HealthContainer.visible = true
			healthbox.value = global.CurrentSelection.hp_val / hp_mul
		else:
			$HealthContainer.visible = false
	
		if "cooldown" in global.CurrentSelection:
			$CooldownContainer.visible = true
			coolbox.value = global.CurrentSelection.cooldown * cooldown_mul
		else:
			$CooldownContainer.visible = false
		
		if "charge" in global.CurrentSelection:
			$ChargeContainer.visible = true
			chargebox.value = global.CurrentSelection.charge
		else:
			$ChargeContainer.visible = false
			
		if global.CurrentSelection != null:
			$HBoxContainer/Button.visible = true
		else:
			$HBoxContainer/Button.visible = false
		
	elif global.CurrentSelection == null:
			$RangeContainer.visible = false
			$DamageContainer.visible = false
			$HealthContainer.visible = false
			$CooldownContainer.visible = false
			$ChargeContainer.visible = false
			$HBoxContainer/Button.visible = false
			
	
	if LastSelection != null:
		if apply == false:
			if "range" in LastSelection:
				LastSelection.range = old_range
			if "damage" in LastSelection:
				LastSelection.damage = old_dmg
			if "hp_val" in LastSelection:
				LastSelection.hp_val = old_hp
			if "hp_scene" in LastSelection:
				LastSelection.hp_scene.initialize_hp()
			if "cooldown" in LastSelection:
				LastSelection.cooldown = old_cooldown 
			if "charge" in LastSelection:
				LastSelection.charge = old_charge
			
		apply = false

func check_price():
	if global.CurrentSelection != null:
		
		price = 0
	
		dmg_diff = 0
		range_diff = 0
		hp_diff = 0
		cooldown_diff = 0
		charge_diff = 0
		
		var seq_off = 0
	
		if "damage" in global.CurrentSelection:
			dmg_diff = (global.CurrentSelection.damage/dmg_mul - global.CurrentSelection.dmg_og)
			seq_off += pricing(global.CurrentSelection.dmg_off)
		if "range" in global.CurrentSelection:
			range_diff = ((global.CurrentSelection.range-100)/range_mul - global.CurrentSelection.range_og)
			seq_off += pricing(global.CurrentSelection.range_off)
		if "hp_val" in global.CurrentSelection:
			hp_diff = (global.CurrentSelection.hp_val/hp_mul - global.CurrentSelection.hp_og)
			seq_off += pricing(global.CurrentSelection.hp_off)
		if "cooldown" in global.CurrentSelection:
			cooldown_diff = (global.CurrentSelection.cooldown * cooldown_mul - global.CurrentSelection.cooldown_og)
			seq_off += pricing(global.CurrentSelection.cooldown_off*-1)
		if "charge" in global.CurrentSelection:
			charge_diff = (global.CurrentSelection.charge - global.CurrentSelection.charge_og)
			seq_off += pricing(global.CurrentSelection.charge_off*1)
			
		var seq = pricing(dmg_diff)+pricing(range_diff)+pricing(hp_diff)+pricing(cooldown_diff*-1)+pricing(charge_diff*-1)
		
		
		price = seq - seq_off 
		
		$HBoxContainer/Button.text = str(price)
		
		if isbought == true:
			if "damage" in global.CurrentSelection:
				global.CurrentSelection.dmg_off = dmg_diff
			if "range" in global.CurrentSelection:
				global.CurrentSelection.range_off = range_diff
			if "hp_val" in global.CurrentSelection:
				global.CurrentSelection.hp_off = hp_diff
			if "cooldown" in global.CurrentSelection:
				global.CurrentSelection.cooldown_off = cooldown_diff
			if "charge" in global.CurrentSelection:
				global.CurrentSelection.charge_off = charge_diff
			price = 0
			$HBoxContainer/Button.text = str(price)
			isbought = false
		
func _on_bought():
	isbought = true
	apply = true
	changed = true

func _on_button_pressed():
	if price <= global.Currency:
		global.Currency -= price
		bought.emit()
		if "cooldown" in global.CurrentSelection:
			global.CurrentSelection.timer.wait_time = coolbox.value / cooldown_mul
	
func _on_damage_box_value_changed(value):
	global.CurrentSelection.damage = damagebox.value * dmg_mul
	changed = true

func _on_range_box_value_changed(value):
	global.CurrentSelection.range = (rangebox.value+10) * range_mul
	changed = true

func _on_healthbox_value_changed(value):
	global.CurrentSelection.hp_val = healthbox.value * hp_mul
	global.CurrentSelection.hp_scene.initialize_hp()
	changed = true

func _on_cooldown_box_value_changed(value):
	global.CurrentSelection.cooldown = coolbox.value / cooldown_mul
	changed = true

func _on_charge_box_value_changed(value):
	global.CurrentSelection.charge = chargebox.value
	changed = true
	
func fibonacci(n):
	var negative = false
	if n < -1:
		n = abs(n)
		negative = true
	if n == 0:
		return 0
	elif n == 1:
		return 1
	elif n == -1:
		return -1
		
	if negative == false:
		return fibonacci(n-1) + fibonacci(n-2)
	if negative == true:
		return (fibonacci(n-1) + fibonacci(n-2))*-1

func pricing(n):
	if n == 0:
		return 0
	else:
		return snapped(pow(n,2)/sqrt(abs(n)), 1)
