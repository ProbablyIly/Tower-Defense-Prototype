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

var dmg_off = 0
var range_off = 0
var hp_off = 0
var cooldown_off = 0
var charge_off = 0

var dmg_diff = 0
var range_diff = 0
var hp_diff = 0
var cooldown_diff = 0
var charge_diff = 0

var dmg_og = 0
var range_og = 0
var hp_og = 0
var cooldown_og = 0
var charge_og = 0


var price = 0

var dmg_mul = 5
var range_mul = 10
var hp_mul = 10
var cooldown_mul = 5
var charge_mul

# Called when the node enters the scene tree for the first time.
func _ready():
	LastSelection = global.CurrentSelection
	$RangeContainer.visible = false
	$DamageContainer.visible = false
	$HealthContainer.visible = false
	$CooldownContainer.visible = false
	$ChargeContainer.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.CurrentSelection != LastSelection:
		editor_update()
		
		
		if global.CurrentSelection != null:
			old_dmg = global.CurrentSelection.damage
			old_range = global.CurrentSelection.range
			old_hp = global.CurrentSelection.hp_val
			old_cooldown = global.CurrentSelection.cooldown
			old_charge = global.CurrentSelection.charge
			
		LastSelection = global.CurrentSelection
			
		if global.CurrentSelection == null:
			$RangeContainer.visible = false
			$DamageContainer.visible = false
			$HealthContainer.visible = false
			$CooldownContainer.visible = false
			$ChargeContainer.visible = false
		
	check_price()

	
func editor_update():
	if global.CurrentSelection != null:
		if global.CurrentSelection.range != null:
			$RangeContainer.visible = true
			rangebox.value = (global.CurrentSelection.range-100) / range_mul
		else:
			$RangeContainer.visible = false
	
		if global.CurrentSelection.damage != null:
			$DamageContainer.visible = true
			damagebox.value = global.CurrentSelection.damage / dmg_mul
		else:
			$DamageContainer.visible = false
		
		if global.CurrentSelection.hp_val != null:
			$HealthContainer.visible = true
			healthbox.value = global.CurrentSelection.hp_val / hp_mul
		else:
			$HealthContainer.visible = false
	
		if global.CurrentSelection.cooldown != null:
			$CooldownContainer.visible = true
			coolbox.value = global.CurrentSelection.cooldown * cooldown_mul
		else:
			$CooldownContainer.visible = false
		
		if global.CurrentSelection.charge != null:
			$ChargeContainer.visible = true
			chargebox.value = global.CurrentSelection.charge
		else:
			$ChargeContainer.visible = false
			
	
	if LastSelection != null:
		if apply == false:
			LastSelection.range = old_range
			LastSelection.damage = old_dmg
			LastSelection.hp_val = old_hp
			LastSelection.hp_scene.initialize_hp()
			LastSelection.cooldown = old_cooldown 
			LastSelection.charge = old_charge
			
		apply = false

func check_price():
	if global.CurrentSelection != null:
		price = 0

		if global.CurrentSelection.damage != null:
			dmg_og = global.CurrentSelection.damage/dmg_mul
		if global.CurrentSelection.range != null:
			range_og = (global.CurrentSelection.range-100)/range_mul
		if global.CurrentSelection.hp_val != null:
			hp_og = global.CurrentSelection.hp_val/hp_mul
		if global.CurrentSelection.cooldown != null:
			cooldown_og = global.CurrentSelection.cooldown*cooldown_mul
		if global.CurrentSelection.charge != null:
			charge_og = global.CurrentSelection.charge
	
		if global.CurrentSelection.damage != null:
			dmg_diff = (dmg_og - old_dmg/dmg_mul)-dmg_off
		if global.CurrentSelection.range != null:
			range_diff = (range_og - (old_range-100)/range_mul)-range_off 
		if global.CurrentSelection.hp_val != null:
			hp_diff = (hp_og - old_hp/hp_mul)-hp_off
		if global.CurrentSelection.cooldown != null:
			cooldown_diff = (cooldown_og - old_cooldown*cooldown_mul)-cooldown_off
		if global.CurrentSelection.charge != null:
			charge_diff = (charge_og - old_charge)-charge_off
			
		price = fibonacci(dmg_diff)+fibonacci(range_diff)+fibonacci(hp_diff)+fibonacci(cooldown_diff*-1)+fibonacci(charge_diff*-1)
		
		$HBoxContainer/Button.text = str(price)
		
		if isbought == true:
			dmg_off += dmg_diff
			range_off += range_diff
			hp_off += hp_diff
			cooldown_off += cooldown_diff
			charge_off += charge_diff
			price = 0
			$HBoxContainer/Button.text = str(price)
			isbought = false
		
func _on_bought():
	isbought = true

func _on_button_pressed():
	if price <= global.Currency:
		global.Currency -= price
		apply = true
		bought.emit()
		if global.CurrentSelection.cooldown != null:
			global.CurrentSelection.timer.wait_time = coolbox.value / cooldown_mul
	
func _on_damage_box_value_changed(value):
	global.CurrentSelection.damage = damagebox.value * dmg_mul

func _on_range_box_value_changed(value):
	global.CurrentSelection.range = (rangebox.value+10) * range_mul

func _on_healthbox_value_changed(value):
	global.CurrentSelection.hp_val = healthbox.value * hp_mul
	global.CurrentSelection.hp_scene.initialize_hp()

func _on_cooldown_box_value_changed(value):
	global.CurrentSelection.cooldown = coolbox.value / cooldown_mul

func _on_charge_box_value_changed(value):
	global.CurrentSelection.charge = chargebox.value
	
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



