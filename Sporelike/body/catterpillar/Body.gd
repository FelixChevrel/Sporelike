extends Node2D

onready var animator = get_child(0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


signal play_step()

signal play_stomp()



func _on_Node2D_forward():
	animator.play("forward")
	emit_signal("play_step")
