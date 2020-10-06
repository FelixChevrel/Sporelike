extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


signal forward()


func _on_Timer_seg1_timeout():
	emit_signal("forward")


func _on_Timer_seg2_timeout():
	emit_signal("forward")


func _on_Timer_seg3_timeout():
	emit_signal("forward")


func _on_Timer_seg4_timeout():
	emit_signal("forward")
