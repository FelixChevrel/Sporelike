extends Node2D


onready var timer_head = get_node("Timer_head")
onready var timer_seg1 = get_node("Timer_seg1")
onready var timer_seg2 = get_node("Timer_seg2")
onready var timer_seg3 = get_node("Timer_seg3")
onready var timer_seg4 = get_node("Timer_seg4")
onready var reset_timer = get_node("Reset_timer")
 

onready var body_segments = get_children() # dans le cas de la chenille, il y a 4 segments + tête
# on a donc les segments suivants, avec leur mouvements.
# 0 : Tête -> (avance apres 0.5 sec)
# 1 : timer tête
# 2 : segment 1 (avance apres 0.75 sec)
# 3 : timer seg 1
# 4 : segment 2 (avance apres 1 sec)
# 5 : timer seg 2
# 6 : segment 3 (avance apres 1.25 sec)
# 7 : timer seg 3
# 8 : segment 4 (avance apres 1.5 sec)
# 9 : timer seg 4
# 10 : reset timer (qui relance le cycle d'animation).
# (temps de pose jusqu'a 4 sec.)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_head.set_wait_time(0.5)
	timer_seg1.set_wait_time(0.75)
	timer_seg2.set_wait_time(1)
	timer_seg3.set_wait_time(1.25)
	timer_seg4.set_wait_time(1.5)
	reset_timer.set_wait_time(4)
	timer_head.start()
	timer_seg1.start()
	timer_seg2.start()
	timer_seg3.start()
	timer_seg4.start()
	reset_timer.start()

func _process(delta):
	# cette fonction calcul les mouvements de la démo créature.
	pass

func _on_Reset_timer_timeout():
	timer_head.set_wait_time(0.5)
	timer_seg1.set_wait_time(0.75)
	timer_seg2.set_wait_time(1)
	timer_seg3.set_wait_time(1.25)
	timer_seg4.set_wait_time(1.5)
	reset_timer.set_wait_time(4)
	timer_head.start()
	timer_seg1.start()
	timer_seg2.start()
	timer_seg3.start()
	timer_seg4.start()
	reset_timer.start()
