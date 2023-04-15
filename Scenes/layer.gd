extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_color_picker_button_picker_created():
	var picker = get_node("ColorPickerButton").get_picker()
#	picker.custom_minimum_size.x = custom_minimum_size.x * 2
#	picker.custom_minimum_size.y = custom_minimum_size.y * 2
#	picker.size = Vector2i(custom_minimum_size.x * 2, custom_minimum_size.y * 2)
#	picker.scale.x = picker.scale.x * 2
#	picker.scale.y = picker.scale.y * 2


#Update the color in the color box
func _on_color_picker_button_color_changed(color):
	get_node("ColorPickerButton").color = color


func _on_layer_data_mouse_entered():
	get_node("LayerData/Outline").set_color(Color(0,0,0,1))


func _on_layer_data_mouse_exited():
	get_node("LayerData/Outline").set_color(Color(1,1,1,1))
