extends Node

var player_name: String:
	get: return PlayerState.player_name
var pronoun: int:
	get: return PlayerState.player_pronoun
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

func set_var(var_name: String, value: bool) -> void:
	PlayerState.vars.set(var_name, value)

func suffer_harm() -> void:
	PlayerState.suffer_harm()
	EventBus.flash()

func add_signature(signer_name: String) -> void:
	PlayerState.signatures.append(signer_name)
	EventBus.signature_added.emit()

func g(home_string: String, muller_string: String, nb_string: String) -> String:
	match pronoun:
		0: return home_string
		1: return muller_string
		_: return nb_string
