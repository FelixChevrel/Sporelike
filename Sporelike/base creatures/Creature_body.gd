extends KinematicBody2D

# give the bodytype_index, as per explained in the "singleton" class. By default, it's 0
var bodytype_index = 0

# an int that allow to get the next head on the singleton.head_array
var head_add = 0

# simimar to "head_add", but it's an array that contain the rotation advancement of each used segments
# as such, it is renewed every-time the body_type change.
var body_add = [0]

# like body_add
var leg_add = [0]

# the current length of the creature. Change with the body type.
var curr_length = 0

# list of the segments (all child nodes). To change the sprites, use the "get_child(0)" to get the first child (the sprite)
onready var segments = get_children()
# the list is: 
# 0 = head_link
### segment[0].get_child(0) = head sprite
# 1 = segment_link
### segment[1].get_child(0) = body sprite
##### Segment[1].get_child(0).get_child(0) = leg sprite
# 2 = segment_link2
# 3 = segment_link3
# 4 = segment_link4

# a var that store the sprite that will be changed.
var demanded_sprite

# var that allow to change the location of the sprites.
var demanded_x
var demanded_y

# var that is used to calculate the movement speed of the creature
var current_speed = 0
var demanded_speed 

# var that is used to calculate the jump height of the creature
var current_jump = 0

# var that allow or block movements.
onready var is_tested = false

onready var gravity =  10

var velocity = Vector2()

# a var that indicate the current direction. -1 if it goes right to left and 1 if left to right
var direction = -1

# a var that indicate if the creature has switched direction
var switch_dir = false


##############################################Separation between variables and functions

func _ready():
	#body length
	## load the body length
	curr_length = Singleton.body_type_legnth[bodytype_index]
	## set body_add
	body_add.resize(curr_length + 1)
	for x in range(body_add.size()):
		body_add[x] = 0
	
	# set leg_add
	leg_add.resize(curr_length + 1)
	for x in range(leg_add.size()):
		leg_add[x] = 0
	
	
	# Head
	## set the base sprite 
	demanded_sprite = Singleton.head_array[bodytype_index]
	segments[0].get_child(0).set_texture( load(demanded_sprite))
	## toggle visibility of the head.
	segments[0].visible = true
	
	#body
	## set all the segments to visible first.
	for x in range(1, segments.size()):
		if (segments[x].visible == true):
			segments[x].visible = false
	## then change each needed sprites and set them visible again.
	for x in range(1, curr_length+1):
		demanded_sprite = Singleton.body_array[bodytype_index]
		segments[x].get_child(0).set_texture( load(demanded_sprite))
		segments[x].visible = true
	
	# load the coordinates of the body
	for x in range(0, curr_length+1): # at this point I have the creature index and the body index (X)
		# first get x & y
		demanded_x = Singleton.body_type_coordinate[bodytype_index][x][0]
		demanded_y = Singleton.body_type_coordinate[bodytype_index][x][1]
		segments[x].set_position(Vector2(demanded_x,demanded_y))
	
	# legs 
	for x in range(1, curr_length+1):
		demanded_sprite = Singleton.leg_array[bodytype_index]
		segments[x].get_child(0).get_child(0).set_texture( load(demanded_sprite))
		segments[x].visible = true

# function that allow to replace the head by that of another animal.
func switch_head():
	# first, rise up the head_add. If it's above "head_array" size, set it back to 0
	head_add += 1
	if (head_add >= Singleton.head_array.size()):
		head_add = 0
	
	# next, get the adequate sprite reference.
	if ((bodytype_index + head_add) >= Singleton.head_array.size()):
		demanded_sprite = Singleton.head_array[0]
	else:
		demanded_sprite = Singleton.head_array[bodytype_index + head_add]
	
	# set the sprite
	segments[0].get_child(0).set_texture( load(demanded_sprite))
	
	pass

# function that allow to replace a body by another. Require an index between 1 and curr_length
func switch_body(index):
	if (index < body_add.size()):
		# first, increase the body_add of the correct index. If it's above "body_array" size, set it back to 0
		body_add[index] += 1
		if (body_add[index] >= Singleton.body_array.size()):
			body_add[index] = 0
		
		# next, get the adequate sprite reference
		if ((bodytype_index + body_add[index]) >= Singleton.body_array.size()):
			demanded_sprite = Singleton.body_array[0]
		else:
			demanded_sprite = Singleton.body_array[bodytype_index + body_add[index]]
		
		#set the sprite
		segments[index].get_child(0).set_texture( load(demanded_sprite))

# allow to change the base body type of the creature.
func switch_body_type():
	
	# reset rotation
	for x in range(0, segments.size()):
		rotate_reset(x)
	
	# rise up the "bodytype index"
	bodytype_index += 1
	if (bodytype_index >= Singleton.body_type_legnth.size()):
		bodytype_index = 0
	
	# next, get the adequate length
	curr_length = Singleton.body_type_legnth[bodytype_index]
	
	# reset "head add", "body add" and "leg add"
	head_add = 0
	body_add.resize(curr_length + 1)
	for x in range(body_add.size()):
		body_add[x] = 0 
	leg_add.resize(curr_length + 1)
	for x in range (leg_add.size()):
		leg_add[x] = 0
	 
	
	# Head
	## set the base sprite 
	demanded_sprite = Singleton.head_array[bodytype_index]
	segments[0].get_child(0).set_texture( load(demanded_sprite))
	## toggle visibility of the head.
	segments[0].visible = true
	
	#body
	## set all the segments to visible first.
	for x in range(1, segments.size()):
		if (segments[x].visible == true):
			segments[x].visible = false
	## then change each needed sprites and set them visible again.
	for x in range(1, curr_length+1):
		demanded_sprite = Singleton.body_array[bodytype_index]
		segments[x].get_child(0).set_texture( load(demanded_sprite))
		segments[x].visible = true
	
	# Legs
	for x in range(1, curr_length+1):
		demanded_sprite = Singleton.leg_array[bodytype_index]
		segments[x].get_child(0).get_child(0).set_texture( load(demanded_sprite))
		segments[x].visible = true
	
	# load the coordinates of the body
	for x in range(0, curr_length+1): # at this point I have the creature index and the body index (X)
		# first get x & y
		demanded_x = Singleton.body_type_coordinate[bodytype_index][x][0]
		demanded_y = Singleton.body_type_coordinate[bodytype_index][x][1]
		segments[x].set_position(Vector2(demanded_x,demanded_y))

func switch_leg(index):
	if (index < leg_add.size()):
		# first, increase the body_add of the correct index. If it's above "body_array" size, set it back to 0
		leg_add[index] += 1
		if (leg_add[index] >= Singleton.leg_array.size()):
			leg_add[index] = 0
		
		# next, get the adequate sprite reference
		if ((bodytype_index + leg_add[index]) >= Singleton.leg_array.size()):
			demanded_sprite = Singleton.leg_array[0]
		else:
			demanded_sprite = Singleton.leg_array[bodytype_index + leg_add[index]]
		
		#set the sprite
		segments[index].get_child(0).get_child(0).set_texture( load(demanded_sprite))

# a function that allow the rotation of a body part, so it connect better.
func rotate(index):
	if (segments[index].get_rotation_degrees() == 360) :
		segments[index].set_rotation_degrees(340)
	else :
		segments[index].set_rotation_degrees( segments[index].get_rotation_degrees() - 20)

func rotate_reset(index):
	segments[index].set_rotation_degrees(0)

# A function that prepare the creature for the "test" mode.
func set_movement_variables():
	current_jump = 0
	current_speed = 0
	
	for x in range(1, curr_length + 1):
		# we use the "current body type" + the addequate "leg add" index to calculate which speed the leg give
		if ((bodytype_index + leg_add[x]) >= segments.size()):
			demanded_speed = 0 + leg_add[x] - 1
		else :
			demanded_speed = bodytype_index + leg_add[x]
		
		# once we know the demanded speed/jump, we can add it to current speed.
		current_speed += Singleton.leg_speed_array[demanded_speed]
		current_jump += Singleton.leg_jump_array[demanded_speed]

# a function that allow to move the demanded segment to the desired location.
func move_segment(index, x, y):
	segments[index].set_position(Vector2(x,y))

###################################################### Separation between func and signals

func _on_change_head_pressed():
	switch_head()

func _on_change_seg1_pressed():
	switch_body(1)

func _on_change_seg2_pressed():
	switch_body(2)

func _on_change_seg3_pressed():
	switch_body(3)

func _on_Change_body_type_pressed():
	switch_body_type()

func _on_change_leg_1_pressed():
	switch_leg(1)

func _on_change_leg_2_pressed():
	switch_leg(2)

func _on_Button_pressed():
	switch_leg(3)

func _on_Rotate_head_pressed():
	rotate(0)

func _on_Rotate_seg1_pressed():
	rotate(1)

func _on_Rotate_seg2_pressed():
	rotate(2)

func _on_Rotate_seg3_pressed():
	rotate(3)

func _on_game_test_sig():
	set_movement_variables()
	is_tested = true

func _on_game_end_test_sig():
	is_tested = false

############################################################# function process, for the movements.

func _physics_process(delta):
	
	if (is_tested):
		velocity.y += gravity
		get_input()
		velocity = move_and_slide(velocity, Vector2(0,1))
		
		
		if (velocity.x != 0):
			if (sign(velocity.x) != direction):
				switch_dir = true
		
		if (switch_dir == true):
			direction *= -1
			scale.x *= -1
			switch_dir = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	
	if is_on_floor() and jump:
		velocity.y += current_jump
	if right:
		velocity.x += current_speed
	if left:
		velocity.x -= current_speed


func _on_new_position_new_position(x, y):
	move_segment(0,x,y)

func _on_new_position2_new_position(x, y):
	move_segment(1,x,y)

func _on_new_position3_new_position(x, y):
	move_segment(2,x,y)

func _on_new_position4_new_position(x, y):
	move_segment(3,x,y)

