extends VBoxContainer

@onready var damagebox = $DamageContainer/DamageBox
@onready var rangebox =  $RangeContainer/RangeBox
@onready var healthbox = $HealthContainer/Healthbox
@onready var coolbox = $CooldownContainer/CooldownBox
@onready var chargebox = $ChargeContainer/ChargeBox


var LastSelection
var apply = false

var old_dmg
var old_range
var old_hp
var old_cooldown
var old_charge

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

	
func editor_update():
	if global.CurrentSelection != null:
		if global.CurrentSelection.range != null:
			$RangeContainer.visible = true
			rangebox.value = global.CurrentSelection.range / 10
		else:
			$RangeContainer.visible = false
	
		if global.CurrentSelection.damage != null:
			$DamageContainer.visible = true
			damagebox.value = global.CurrentSelection.damage
		else:
			$DamageContainer.visible = false
		
		if global.CurrentSelection.hp_val != null:
			$HealthContainer.visible = true
			healthbox.value = global.CurrentSelection.hp_val / 10
		else:
			$HealthContainer.visible = false
	
		if global.CurrentSelection.cooldown != null:
			$CooldownContainer.visible = true
			coolbox.value = global.CurrentSelection.cooldown
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


func _on_button_pressed():
	apply = true
	if global.CurrentSelection.cooldown != null:
		global.CurrentSelection.timer.wait_time = coolbox.value
	
func _on_damage_box_value_changed(value):
	global.CurrentSelection.damage = damagebox.value 

func _on_range_box_value_changed(value):
	global.CurrentSelection.range = rangebox.value * 10

func _on_healthbox_value_changed(value):
	global.CurrentSelection.hp_val = healthbox.value * 10
	global.CurrentSelection.hp_scene.initialize_hp()

func _on_cooldown_box_value_changed(value):
	global.CurrentSelection.cooldown = coolbox.value


func _on_charge_box_value_changed(value):
	global.CurrentSelection.charge = chargebox.value
