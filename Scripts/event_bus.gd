extends Node

var world: World:
	get: return get_world()
	set(value): set_world(value)

var _world: World

signal dialogue_started
signal dialogue_ended
signal conflict_started(conflict_name: StringName)
signal conflict_ended

func set_world(new_world: World):
	_world = new_world

func get_world() -> World:
	return _world
