extends ColorPickerButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_picker_created():
	var picker = get_picker()
#	picker.custom_minimum_size.x = custom_minimum_size.x * 2
#	picker.custom_minimum_size.y = custom_minimum_size.y * 2
	picker.size = Vector2i(custom_minimum_size.x * 2, custom_minimum_size.y * 2)
#	picker.scale.x = picker.scale.x * 2
#	picker.scale.y = picker.scale.y * 2
