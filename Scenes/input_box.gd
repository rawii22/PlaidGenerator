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


#This is a dangerously catch-all function that validates input based on which box is being changed.
#If the Rotation box is being changed, it will allow one hyphen at the front of the input which means it allows for positive and negative numbers.
#Otherwise, it will only allow positive numbers.
func _on_text_changed(new_text):
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
	get_parent().update()


#If anything other than the LayerID box is being submitted, clean the input and validate Rotation's box.
#If LayerID is being submitted, if it is valid, then change the layer position. Otherwise, change back to original value.
func _on_text_submitted(new_text):
	if self.name == "LayerID":
		if new_text != original_layer and new_text != "":
			changing_position = true
			get_tree().get_root().get_node("Main/Layers").move_layer(self.get_parent(), int(new_text))
		else:
			self.text = original_layer
		release_focus()
		return
	remove_leading_zeros()
	validate_rotation()
	get_parent().update()


#If focus is exited on boxes other than LayerID, clean them and leave them alone since they've already been
# checked by the _on_text_changed function.
#If focus is exited on LayerID, change it back to the original value. However, if focus is exited
# after a layer change was just submitted, do not change the layer text, and then turn off the warning.
func _on_focus_exited():
	if self.name == "LayerID":
		if !changing_position:
			self.text = original_layer
		else:
			changing_position = false
		return
	remove_leading_zeros()
	validate_rotation()


#If LayerID is selected, save the original layer in case the text is changed but not submitted.
func _on_focus_entered():
	if self.name == "LayerID":
		original_layer = self.text


func remove_leading_zeros():
	self.text = str(input_num)
	self.set_caret_column(self.text.length())


#Change the angle in the Rotation box to be the corresponding angle within +/- 180 degrees.
func validate_rotation():
	if self.name == "Rotation":
		if input_num < 0 or input_num >= 180:
			self.text = str(input_num % 180)
			self.set_caret_column(self.text.length())


