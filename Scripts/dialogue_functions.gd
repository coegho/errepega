extends Node

var player_name: String = "CAMARADA"

var conflict: Conflict

func start_conflict(conflict_name: String) -> void:
	conflict = get_conflict(conflict_name)
	EventBus.world.start_conflict(conflict)
	EventBus.conflict_started.emit(conflict_name)

func end_conflict() -> void:
	EventBus.world.end_conflict()
	EventBus.conflict_ended.emit()

func get_conflict(conflict_name: String) -> Conflict:
	return load(str("res://world/conflicts/", conflict_name.to_lower(), ".tres"))
