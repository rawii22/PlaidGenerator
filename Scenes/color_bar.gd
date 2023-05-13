extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("color_bar")


func construct(color, width):
	$ColorRect.color = color
	$ColorRect.size.x = width
	$ColorRect.position.x = (-1) * (width/2)
