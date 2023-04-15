extends Node2D


var layer_ID = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	layer_ID = get_parent().get_parent().get_parent().num_layers
	self.name = str(layer_ID)
	$LayerID.text = str(layer_ID)
	if layer_ID != 1:
		self.position = get_parent().get_node(str((layer_ID - 1))).position + Vector2(0,200)
	
	#TODO: Make the Layer ID editable so people can type what layer they want to shift it to. Shift all others down by one


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_color_picker_button_picker_created():
	var picker = $ColorPickerButton.get_picker()
#	picker.custom_minimum_size.x = custom_minimum_size.x * 2
#	picker.custom_minimum_size.y = custom_minimum_size.y * 2
#	picker.size = Vector2i(custom_minimum_size.x * 2, custom_minimum_size.y * 2)
#	picker.scale.x = picker.scale.x * 2
#	picker.scale.y = picker.scale.y * 2


#Update the color in the color box
func _on_color_picker_button_color_changed(color):
	$ColorPickerButton.color = color


func _on_layer_data_mouse_entered():
	$LayerData/Outline.set_color(Color(0,0,0,1))


func _on_layer_data_mouse_exited():
	$LayerData/Outline.set_color(Color(1,1,1,1))


func _on_delete_pressed():
	get_parent().get_parent().get_parent().remove_layer(self)


func _on_duplicate_pressed():
	get_parent().get_parent().get_parent().create_existing_layer($ColorPickerButton.color, $XPos.text, $YPos.text, $Width.text, $Rotation.text)


func set_color(color): $ColorPickerButton.color = color

func set_x(x): $XPos.text = x

func set_y(y): $YPos.text = y

func set_width(width): $Width.text = width

func set_degree(degree): $Rotation.text = degree


func update_ID(newID):
	self.name = str(newID)
	layer_ID = newID
	$LayerID.text = str(layer_ID)
