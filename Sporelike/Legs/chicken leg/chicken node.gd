extends Node2D


onready var animator = get_node("AnimationPlayer")


func _on_chickenleg_link_step():
	animator.play("step")
