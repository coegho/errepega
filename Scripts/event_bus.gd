extends Node

var world: World:
	get: return get_world()
	set(value): set_world(value)

var _world: World

signal dialogue_started
signal dialogue_ended
signal conflict_started(conflict_name: StringName)
signal conflict_ended
signal flash_signal
signal signature_added
signal end_all_dialogues
signal win_condition
signal back_to_menu
signal music_requested(music: String)

func set_world(new_world: World):
	_world = new_world

func get_world() -> World:
	return _world

func flash() -> void:
	flash_signal.emit()
