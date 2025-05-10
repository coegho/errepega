extends Node

var player_name: String = "CAMARADA"

var conflict: Conflict

func start_conflict(conflict_name: String) -> void:
	conflict = ContentLoader.load_conflict(conflict_name)
	EventBus.world.start_conflict(conflict)
	EventBus.conflict_started.emit(conflict_name)

func end_conflict() -> void:
	EventBus.world.end_conflict()
	EventBus.conflict_ended.emit()

func change_location(
	location_name: String,
	teleport_to_position: Vector2i = Vector2i.ZERO,
	new_orientation: Vector2i = Vector2i.DOWN,
	new_velocity: Vector2i = Vector2i.ZERO
	) -> void:
	var new_location := ContentLoader.load_location(location_name)
	EventBus.world.change_location(new_location, teleport_to_position, new_orientation, new_velocity)

func display_name_select() -> void:
	EventBus.world.display_name_select()

func get_var(var_name: String) -> bool:
	return PlayerState.vars.get(var_name) or false
