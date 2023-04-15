extends Node2D

var Layer = preload("res://Scenes/layer.tscn")
var num_layers = 0

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


#This function changes the number of layers internally and on the front end based on the given amount.
#For this program, it is unlikely that "delta" will be anything except 1 or -1
func layer_count_delta(delta):
	num_layers += delta
	$LayerCounter.text = "Layers: " + str(num_layers)


func create_new_layer():
	if (num_layers < 999):
		layer_count_delta(1)
		var layer_list = get_node("ScrollContainer/LayerList")
		layer_list.custom_minimum_size += Vector2(0, 200)
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
		layer_list.custom_minimum_size += Vector2(0, 200)
		layer_list.add_child(new_layer)


func remove_layer(node):
	var removed_node_ID = node.layer_ID
	var layer_list = get_node("ScrollContainer/LayerList")
	
	layer_list.remove_child(node)
	node.queue_free()
	
	for n in range(removed_node_ID + 1, num_layers + 1):
		var current_layer = layer_list.get_node(str(n))
		current_layer.position -= Vector2(0, 200)
		current_layer.update_ID(current_layer.layer_ID - 1)
		
	layer_count_delta(-1)
	layer_list.custom_minimum_size -= Vector2(0, 200)
	
	#TODO: Make it possible to just shift layers. Influence the ordering of images on the canvas
