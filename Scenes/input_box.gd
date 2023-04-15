extends LineEdit


var old_text = ""
var input_num = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_changed(new_text):
	#Only numbers are allowed in all the boxes. The Rotation box allows for negative numbers
	if !new_text.is_valid_int() and new_text != "":
		if self.name == "Rotation" and new_text == "-" and new_text.count("-") <= 1:
			pass
		else:
			self.text = old_text
			self.set_caret_column(self.text.length())
			return
	old_text = new_text
	input_num = int(new_text)


func _on_text_submitted(new_text):
	remove_leading_zeros()
	validate_rotation()


func _on_focus_exited():
	remove_leading_zeros()
	validate_rotation()


func remove_leading_zeros():
	self.text = str(input_num)
	self.set_caret_column(self.text.length())


func validate_rotation():
	if self.name == "Rotation":
		if input_num < 0 or input_num >= 180:
			self.text = str(input_num % 180)
			self.set_caret_column(self.text.length())
