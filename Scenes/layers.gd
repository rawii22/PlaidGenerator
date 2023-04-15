extends Node2D

var Layer = preload("res://Scenes/layer.tscn")
var num_layers = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_layer_button_pressed():
	create_new_layer()


func _input(event):
	if event.is_action_pressed("Create New Layer"):
		create_new_layer()


func create_new_layer():
	num_layers += 1
	get_node("ScrollContainer/VBoxContainer").add_child(Layer.instantiate())
