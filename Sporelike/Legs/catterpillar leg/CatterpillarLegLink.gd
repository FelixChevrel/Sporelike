extends Node2D

signal step()

func _on_Catterpillar_body_play_step():
	emit_signal("step")
