extends Node

# for references, each "base creature" has an index that will be the same for each list. 
# 0 = catterpillar
# 1 = chicken
# 2 = fake goat
# if there is a structure that require more than one elements,

# an array that give the body type length, without counting the head.
onready var body_type_legnth = [3, 1, 1]

# an array that contain an series of coordinates (in array form) for each segments INCLUDING the head.
# this take the form of: [ creature_type[ segments [x, y]]]
onready var body_type_coordinate = [ [ [0,0]  ,[36,0] ,[72,0] ,[108,0] ], #catterpillar
									 [[0,0],[10,50]], # chicken
									 [[0,0],[0,0]] # fake goat
									]
# to get access to those coordinates, it's body_type_coordinate[][][]
# for more readability, this is divided by lines, with one line = one creature type

# an array that contain the ref to all the head sprites
onready var head_array = ["res://sprite/catterpillar head.png", "res://sprite/chicken head.png", "res://sprite/goat face.png"]

# an array that contain the ref to all the body sprites
onready var body_array = ["res://sprite/Catterpillar body.png", "res://sprite/chicken body.png", "res://sprite/goat body.png"]

# an array that contain the ref to all the leg sprites
# WARNING: The chicken leg has 2 sprites
onready var leg_array = ["res://sprite/catterpillar leg.png", "res://sprite/chicken leg 1.png", "res://sprite/goat legs.png"]
						#["res://sprite/chicken leg 1.png","res://sprite/chickenleg2.png"]]

# an array that contain the speed of each legs. 
# we assume that the base creature leg is the one that is refer by the number, instead of the body type.
onready var leg_speed_array = [75, 150, 300]
onready var leg_jump_array = [0, 100, 200]

# an array that contain the animation reference of the legs.
onready var leg_anim_array = ["", "", ""]


