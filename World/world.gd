class_name World extends Node2D

@export var conflict_scene: PackedScene

var tilemaps: Array[TileMapLayer] = []
var open_dialogue: bool = false
var current_conflict: ConflictScene = null

func _init() -> void:
	EventBus.set_world(self)
	EventBus.dialogue_started.connect(_on_dialogue_started)
	EventBus.dialogue_ended.connect(_on_dialogue_ended)

func _ready() -> void:
	for node in find_children("*", "TileMapLayer", false):
		var layer: TileMapLayer = node
		tilemaps.append(layer)

func is_occupied(grid_position: Vector2i) -> bool:
	for layer in tilemaps:
		var data := layer.get_cell_tile_data(grid_position)
		if not data:
			return true
		if data.get_custom_data("solid"):
			return true
	return false

func start_conflict(conflict: Conflict) -> void:
	current_conflict = conflict_scene.instantiate()
	add_child(current_conflict)
	current_conflict.initialize_scene(conflict)

func end_conflict() -> void:
	current_conflict.queue_free()
	current_conflict = null

#region signals

func _on_dialogue_started() -> void:
	open_dialogue = true

func _on_dialogue_ended() -> void:
	open_dialogue = false
#endregion
