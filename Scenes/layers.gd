extends Node2D

var Layer = preload("res://Scenes/layer.tscn")
var canvas
var layers = []

#TODO: Please find a better way of fetching this value that does NOT require it to be hard coded if changed.
var layer_size = Vector2(1200, 200)
var layer_height = Vector2(0, layer_size.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas = get_tree().get_root().get_node("Main/Canvas")
	$LayerCounter.text = "Layers: 0"


func _on_new_layer_button_pressed():
	create_new_layer()


func _input(event):
	if event.is_action_pressed("Create New Layer"):
		create_new_layer()


#This function changes the number of layers internally and on the front-end based on the given amount.
#For this program, it is unlikely that "delta" will be anything except 1 or -1
func layer_count_changed():
	$LayerCounter.text = "Layers: " + str(layers.size())


func get_layer_count():
	return layers.size()


func create_new_layer():
	if (get_layer_count() < 999):
		var layer_list = get_node("ScrollContainer/LayerList")
		layer_list.custom_minimum_size += layer_height
		var new_layer = Layer.instantiate()
		layer_list.add_child(new_layer)
		layers.push_back(new_layer)
		layer_count_changed()
		canvas.update_canvas()


#This function should be useful for duplicating layers or loading in layers from files
func create_existing_layer(color, x, y, width, degree, layer_ID):
	if (get_layer_count() < 999):
		var new_layer = Layer.instantiate()
		new_layer.set_color(color)
		new_layer.set_x(x)
		new_layer.set_y(y)
		new_layer.set_width(width)
		new_layer.set_degree(degree)
		
		var layer_list = get_node("ScrollContainer/LayerList")
		layer_list.custom_minimum_size += layer_height
		layer_list.add_child(new_layer)
		layers.push_back(new_layer)
		layer_count_changed()
		move_layer(new_layer, layer_ID + 1)
		canvas.update_canvas()


#Removes a specified layer
func remove_layer(node):
	var removed_node_ID = node.layer_ID
	var layer_list = get_node("ScrollContainer/LayerList")
	
	layer_list.remove_child(node)
	node.queue_free()
	layers.remove_at(removed_node_ID - 1)
	
	for n in range(removed_node_ID + 1, get_layer_count() + 1):
		var current_layer = layer_list.get_node(str(n))
		current_layer.position -= layer_height
		current_layer.update_ID(current_layer.layer_ID - 1)
		
	layer_count_changed()
	layer_list.custom_minimum_size -= layer_height
	canvas.update_canvas()


#Given a layer and a position, the layer will be moved to the specified position in the list
func move_layer(layer, new_position):
	if new_position >= get_layer_count():
		new_position = get_layer_count() - 1
	
	var original_position = layer.layer_ID
	if new_position == original_position:
		layer.update_ID(original_position)
		return
	
	if new_position > original_position: #If the layer was moved lower
		for n in range(original_position + 1, new_position + 1):
			var current_layer = layers[n]
			current_layer.position -= layer_height
			current_layer.update_ID(current_layer.layer_ID - 1)
	else:
		for n in range(new_position, original_position): #If the layer was moved higher
			var current_layer = layers[n]
			current_layer.position += layer_height
			current_layer.update_ID(current_layer.layer_ID + 1)
	
	#This is just to keep things internally consistent too
	get_node("ScrollContainer/LayerList").move_child(layer, new_position)

	layers.remove_at(original_position)
	layers.insert(new_position, layer)

	layer.update_ID(new_position)
	layer.position = get_node("ScrollContainer/LayerList").position + (layer_size / 2) + (layer_height * new_position)
	canvas.update_canvas()
