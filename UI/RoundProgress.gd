extends ProgressBar

var splits

var increase_i = 0
var current = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increase():
	increase_i += 1
	if increase_i == 4:
		if current > splits.size():
			current += 1
			increase_i = 0
	value += (max_value/splits[current])/4
	

func initiate_markers(split):
	
	value = 0
	current = 0
	increase_i = 0
	
	
	var width = size.x
	
	if split == 0:
		$Marker1.position.x = (width/2)
		$Marker1.visible = true
		$Marker2.position.x = width
		$Marker2.visible = true
		splits = [2,1]
	elif split == 1:
		$Marker1.position.x = (width/4)
		$Marker1.visible = true
		$Marker2.position.x = (width/2)
		$Marker2.visible = true
		$Marker3.position.x = (width)
		$Marker3.visible = true
		splits = [4,2,1]
	elif split == 2:
		$Marker1.position.x = (width/3)
		$Marker1.visible = true
		$Marker2.position.x = ((width*2)/3)
		$Marker2.visible = true
		$Marker3.position.x = (width)
		$Marker3.visible = true
		splits = [3,1.5,1]
	elif split == 3:
		$Marker1.position.x = (width)
		$Marker1.visible = true
		splits = [1]
