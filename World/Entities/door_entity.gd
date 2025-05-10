class_name DoorEntity extends Entity

@export var new_location_name: String
@export var starting_position: Vector2i = Vector2i.ZERO

var new_location: PackedScene:
	get: return load(str("res://world/locations/", new_location_name, ".tscn"))
