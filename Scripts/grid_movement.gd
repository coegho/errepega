class_name GridMovement extends RefCounted

static func grid_to_pixel(grid_position: Vector2i) -> Vector2:
	return Vector2(grid_position*16 + Vector2i.ONE*8)

static func pixel_to_grid(global_position: Vector2) -> Vector2i:
	return Vector2i((global_position - Vector2.ONE*8)/16)
