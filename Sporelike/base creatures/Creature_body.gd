extends Node2D

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
