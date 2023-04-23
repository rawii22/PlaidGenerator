extends LineEdit

var original_layer
var old_text = ""
var input_num = 0
var changing_position = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_changed(new_text):
	#Only numbers are allowed in all the boxes. The Rotation box allows for negative numbers
	if !new_text.is_valid_int() and new_text != "":
		if !(self.name == "Rotation" and new_text == "-" and new_text.count("-") <= 1):
			self.text = old_text
			self.set_caret_column(self.text.length())
			return
	elif self.name != "Rotation" and new_text.contains("-"):
		self.text = old_text
		self.set_caret_column(self.text.length())
		return
	old_text = new_text
	input_num = int(new_text)


func _on_text_submitted(new_text):
	if self.name == "LayerID":
		if new_text != original_layer and new_text != "" and int(new_text) != 0:
			changing_position = true
			get_tree().get_root().get_node("Main/Layers").move_layer(self.get_parent(), int(new_text))
		else:
			self.text = original_layer
		release_focus()
		return
	remove_leading_zeros()
	validate_rotation()


func _on_focus_exited():
	if self.name == "LayerID":
		if !changing_position:
			self.text = original_layer
		else:
			changing_position = false
		return
	remove_leading_zeros()
	validate_rotation()


func _on_focus_entered():
	if self.name == "LayerID":
		original_layer = self.text


func remove_leading_zeros():
	self.text = str(input_num)
	self.set_caret_column(self.text.length())


func validate_rotation():
	if self.name == "Rotation":
		if input_num < 0 or input_num >= 180:
			self.text = str(input_num % 180)
			self.set_caret_column(self.text.length())


