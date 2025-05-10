extends Node

func load_location(location_name: String) -> PackedScene:
	return load(str("res://world/locations/", location_name.to_lower(), ".tscn"))

func load_conflict(conflict_name: String) -> Conflict:
	return load(str("res://world/conflicts/", conflict_name.to_lower(), ".tres"))
