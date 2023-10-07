extends TileMap

var matrix = [
	[0,1,-1,-1,1,1,2,-1],
	[1,0,3,-1,-1,-1,3,1],
	[-1,3,0,-1,-1,1,-1,3],
	[-1,-1,-1,0,2,-1,1,-1],
	[1,-1,-1,2,0,-1,-1,-1],
	[1,-1,1,-1,-1,0,1,3],
	[2,3,-1,1,-1,1,0,2],
	[-1,1,3,-1,-1,3,2,0],
]

var character_position = Vector2i(1, 1)
var delay = 0
var is_moving = false
var movement_index = 0
var route = []

# This function is responsible for executing each frame equally, native to the engine.
func _physics_process(delta):
	_build_world(matrix)
	_build_character()
	if is_moving:
		delay += delta

# This function creates the character.
func _build_character():
	set_cell(2, character_position, 6, Vector2i(-1, -1))
	if delay > 0.5:
		if movement_index < len(route):
			character_position = route[movement_index]
		if movement_index == len(route):
			is_moving = false
		movement_index += 1
		delay = 0
	set_cell(2, character_position, 6, Vector2i(6, 117))

# This function creates the map using an array with weights from -1 to 4.
func _build_world(matrix):
	for abscissa in range(len(matrix)):
		for ordinate in range(len(matrix[abscissa])):
			set_cell(1, Vector2i(ordinate + 1, abscissa + 1), 2, _build_tile(matrix[ordinate][abscissa]))

# This function creates each tile based on the weight received.
func _build_tile(type):
	if type == -1:
		return Vector2i(7, 37)
	if type == 0:
		return Vector2i(0, 0)
	if type == 1:
		return Vector2i(1, 3)
	if type == 2:
		return Vector2i(4, 0)
	if type == 3:
		return Vector2i(5, 2)

# This function manages button inputs, in this case the mouse click, native to the engine.
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_moving = true
			var _clicked_cell = local_to_map(event.position)
			# TODO: Place your pathfinder here with the "clicked_cell" value.
			# TODO: Update the route bellow with the pathfinder route.
			route = [
				Vector2i(1,2),
				Vector2i(1,3),
				Vector2i(1,4),
				Vector2i(1,5),				Vector2i(2,5),
				Vector2i(2,6),
				Vector2i(3,6),
				Vector2i(4,6),
			]
