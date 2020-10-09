extends Button


var x = 0
var y = 0

signal new_position(x,y)

func _process(delta):
	if (pressed):
		emit_signal("new_position", x, y)


func _on_coordinate_y_text_entered(new_text):
	y = float(new_text)

func _on_coordinate_x_text_entered(new_text):
	x = float(new_text)
