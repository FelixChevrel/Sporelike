extends Node2D


func start_test():
	# deactivate all unneeded buttons
	get_child(2).get_child(0).disabled = true
	get_child(2).get_child(0).visible = false
	get_child(2).disabled = true
	get_child(2).visible = false
	get_child(3).get_child(0).disabled = true
	get_child(3).get_child(0).visible = false
	get_child(3).get_child(1).disabled = true
	get_child(3).get_child(1).visible = false
	get_child(3).disabled = true
	get_child(3).visible = false
	get_child(4).get_child(0).disabled = true
	get_child(4).get_child(0).visible = false
	get_child(4).get_child(1).disabled = true
	get_child(4).get_child(1).visible = false
	get_child(4).disabled = true
	get_child(4).visible = false
	get_child(5).get_child(0).disabled = true
	get_child(5).get_child(0).visible = false
	get_child(5).get_child(1).disabled = true
	get_child(5).get_child(1).visible = false
	get_child(5).disabled = true
	get_child(5).visible = false
	get_child(6).disabled = true
	get_child(6).visible = false
	get_child(8).disabled = true
	get_child(9).disabled = false
	emit_signal("test_sig")

func end_test():
	# deactivate all unneeded buttons
	get_child(2).get_child(0).disabled = false
	get_child(2).get_child(0).visible = true
	get_child(2).disabled = false
	get_child(2).visible = true
	get_child(3).get_child(0).disabled = false
	get_child(3).get_child(0).visible = true
	get_child(3).get_child(1).disabled = false
	get_child(3).get_child(1).visible = true
	get_child(3).disabled = false
	get_child(3).visible = true
	get_child(4).get_child(0).disabled = false
	get_child(4).get_child(0).visible = true
	get_child(4).get_child(1).disabled = false
	get_child(4).get_child(1).visible = true
	get_child(4).disabled = false
	get_child(4).visible = true
	get_child(5).get_child(0).disabled = false
	get_child(5).get_child(0).visible = true
	get_child(5).get_child(1).disabled = false
	get_child(5).get_child(1).visible = true
	get_child(5).disabled = false
	get_child(5).visible = true
	get_child(6).disabled = false
	get_child(6).visible = true
	get_child(8).disabled = false
	get_child(9).disabled = true
	emit_signal("end_test_sig")


func _on_movement_test_pressed():
	start_test()

func _on_movement_test_end_pressed():
	end_test()

signal test_sig()

signal end_test_sig()
