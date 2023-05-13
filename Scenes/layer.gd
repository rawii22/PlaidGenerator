extends Node2D


var layer_ID = -1
var canvas

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas = get_tree().get_root().get_node("Main/Canvas")
	$ColorPickerButton.color.a = 1.0
	layer_ID = get_tree().get_root().get_node("Main/Layers").get_layer_count()
	$LayerID.text = str(layer_ID)
	if layer_ID != 0:
		self.position = get_tree().get_root().get_node("Main/Layers").layers[layer_ID - 1].position + Vector2(0,200)


#TODO: Resize color picker panel, it needs to be bigger.

func _on_color_picker_button_picker_created():
	pass
#	var picker = $ColorPickerButton.get_picker()	
	
#	picker.custom_minimum_size.x = custom_minimum_size.x * 2
#	picker.custom_minimum_size.y = custom_minimum_size.y * 2
#	picker.size = Vector2i(custom_minimum_size.x * 2, custom_minimum_size.y * 2)
#	picker.scale.x = picker.scale.x * 2
#	picker.scale.y = picker.scale.y * 2


#Update the color in the color box
func _on_color_picker_button_color_changed(color):
	$ColorPickerButton.color = color
	update()


func _on_layer_data_mouse_entered():
	$LayerData/Outline.set_color(Color(0,0,0,1))


func _on_layer_data_mouse_exited():
	$LayerData/Outline.set_color(Color(1,1,1,1))


func _on_delete_pressed():
	get_tree().get_root().get_node("Main/Layers").remove_layer(self)


func _on_duplicate_pressed():
	get_tree().get_root().get_node("Main/Layers").create_existing_layer($ColorPickerButton.color, $XPos.text, $YPos.text, $Width.text, $Rotation.text, layer_ID)


func set_color(color): $ColorPickerButton.color = color

func set_x(x): $XPos.text = x

func set_y(y): $YPos.text = y

func set_width(width): $Width.text = width

func set_degree(degree): $Rotation.text = degree


func get_color(): return $ColorPickerButton.color

func get_x(): return int($XPos.text)

func get_y(): return int($YPos.text)

func get_width(): return int($Width.text)

func get_degree(): return int($Rotation.text)


func update():
	canvas.update_canvas()


func update_ID(newID):
	layer_ID = newID
	$LayerID.text = str(newID)
