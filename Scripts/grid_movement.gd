class_name GridMovement extends RefCounted

static func grid_to_pixel(grid_position: Vector2i) -> Vector2:
	return Vector2(grid_position.x*16 + 8, grid_position.y*16 + 8)

static func pixel_to_grid(global_position: Vector2) -> Vector2i:
	return Vector2i(round(global_position.x - 8)/16, round(global_position.y - 8)/16)
