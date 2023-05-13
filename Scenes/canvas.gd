extends Control

@export var ColorBar: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_canvas():
	var layers = get_tree().get_root().get_node("Main/Layers").layers
	get_tree().call_group("color_bar", "queue_free")
	
	for layer in layers:
		var new_bar = ColorBar.instantiate()
		add_child(new_bar)
		move_child(new_bar, 3)
		new_bar.construct(layer.get_color(), layer.get_width())
		if layer.get_x() > 4000:
			new_bar.position.x = 5000
		elif layer.get_x() < -4000:
			new_bar.position.x = -5000
		else:
			new_bar.position.x = layer.get_x() + 1000
		
		if layer.get_y() > 4000:
			new_bar.position.y = 5000
		elif layer.get_y() < -4000:
			new_bar.position.y = -5000
		else:
			new_bar.position.y = layer.get_y() + 1000
		new_bar.rotation_degrees = layer.get_degree()
