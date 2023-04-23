extends Node2D

var Layer = preload("res://Scenes/layer.tscn")
var num_layers = 0
var layer_size = Vector2(1200, 200) #Please find a better way of getting this value
var layer_height = Vector2(0, layer_size.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	$LayerCounter.text = "Layers: " + str(num_layers)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_layer_button_pressed():
	create_new_layer()


func _input(event):
	if event.is_action_pressed("Create New Layer"):
		create_new_layer()


#This function changes the number of layers internally and on the front-end based on the given amount.
#For this program, it is unlikely that "delta" will be anything except 1 or -1
func layer_count_delta(delta):
	num_layers += delta
	$LayerCounter.text = "Layers: " + str(num_layers)


func create_new_layer():
	if (num_layers < 999):
		layer_count_delta(1)
		var layer_list = get_node("ScrollContainer/LayerList")
		layer_list.custom_minimum_size += layer_height
		layer_list.add_child(Layer.instantiate())


#This function should be useful for duplicating layers or loading in layers from files
func create_existing_layer(color, x, y, width, degree):
	if (num_layers < 999):
		layer_count_delta(1)
		var new_layer = Layer.instantiate()
		new_layer.set_color(color)
		new_layer.set_x(x)
		new_layer.set_y(y)
		new_layer.set_width(width)
		new_layer.set_degree(degree)
		
		var layer_list = get_node("ScrollContainer/LayerList")
		layer_list.custom_minimum_size += layer_height
		layer_list.add_child(new_layer, true)


#Removes a specified layer
func remove_layer(node):
	var removed_node_ID = node.layer_ID
	var layer_list = get_node("ScrollContainer/LayerList")
	
	layer_list.remove_child(node)
	node.queue_free()
	
	for n in range(removed_node_ID + 1, num_layers + 1):
		var current_layer = layer_list.get_node(str(n))
		current_layer.position -= layer_height
		current_layer.update_ID(current_layer.layer_ID - 1)
		
	layer_count_delta(-1)
	layer_list.custom_minimum_size -= layer_height


#Given a layer and a position, the layer will be moved to the specified position in the list
func move_layer(layer, new_position):
	if new_position > num_layers:
		new_position = num_layers
	
	var original_position = layer.layer_ID
	if new_position == original_position:
		layer.update_ID(original_position)
		return
	
	var layer_list_scene = get_node("ScrollContainer/LayerList")
	
	var layer_list = layer_list_scene.get_children()
	if new_position > original_position: #If the layer was moved lower
		for n in range(original_position + 1, new_position + 1):
			var current_layer = layer_list[n-1]
			current_layer.position -= layer_height
			current_layer.update_ID(current_layer.layer_ID - 1)
	else:
		for n in range(new_position, original_position): #If the layer was moved higher
			var current_layer = layer_list[n-1]
			current_layer.position += layer_height
			current_layer.update_ID(current_layer.layer_ID + 1)
	
	layer_list_scene.move_child(layer, new_position - 1)
	layer.update_ID(new_position)
	layer.position = get_node("ScrollContainer/LayerList").position + (layer_size / 2) + (layer_height * (new_position - 1))
