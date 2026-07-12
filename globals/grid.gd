extends Node

var _grid := AStarGrid2D.new()
var _world_origin := Vector2.ZERO
var _cell_size := Vector2.ONE
var _region := Rect2i()
var _scale := Vector2.ONE
var _initialized := false

func setup(region: Rect2i, cell_size: Vector2, world_origin := Vector2.ZERO) -> void:
	_region = region
	_world_origin = world_origin
	_cell_size = cell_size
	_grid = AStarGrid2D.new()
	_grid.region = region
	_grid.cell_size = cell_size
	_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_grid.update()
	_initialized = true

func world_to_cell(position: Vector2) -> Vector2i:
	var local_position := position - _world_origin
	return _region.position + Vector2i(
		floori(local_position.x / _cell_size.x),
		floori(local_position.y / _cell_size.y)
	)

func cell_to_world(cell: Vector2i) -> Vector2:
	var local_cell := cell - _region.position
	return (_world_origin + Vector2(local_cell) * _cell_size + _cell_size * 0.5)

func set_cell_blocked(cell: Vector2i, blocked := true) -> void:
	if not _initialized:
		push_error("Grid has not initialized")
		return
	if not _grid.is_in_boundsv(cell): return
	_grid.set_point_solid(cell, blocked)

func set_cells_blocked(cells: Array[Vector2i], blocked := true) -> void:
	for cell in cells:
		set_cell_blocked(cell, blocked)

func is_cell_blocked(cell: Vector2i) -> bool:
	if not _initialized: return true
	if not _grid.is_in_boundsv(cell):
		return true
	return _grid.is_point_solid(cell)

func get_cell_path(start_cell: Vector2i, target_cell: Vector2i, allow_partial_path := false) -> Array[Vector2i]:
	if not _initialized: return []
	if not _grid.is_in_boundsv(start_cell):
		return []
	if not _grid.is_in_boundsv(target_cell):
		return []
	return _grid.get_id_path(
		start_cell,
		target_cell,
		allow_partial_path
	)
func get_world_path(start_position: Vector2, target_position: Vector2, allow_partial_path := false) -> PackedVector2Array:
	if not _initialized: return []
	var start_cell := world_to_cell(start_position)
	var target_cell := world_to_cell(target_position)
	var cell_path := get_cell_path(start_cell, target_cell, allow_partial_path)
	var world_path := PackedVector2Array()
	for cell in cell_path:
		world_path.append(cell_to_world(cell))
	return world_path
