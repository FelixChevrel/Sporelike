extends Node2D


onready var animator = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_headlink_forward():
	animator.play("forward")
