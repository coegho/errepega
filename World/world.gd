class_name World extends Node2D

@export var conflict_scene: PackedScene
@export var starting_location: PackedScene
@export var name_select_ui: PackedScene
@export var win_condition_scene: PackedScene

@onready var flash: ColorRect = %Flash

var starting_position: Vector2i = Vector2i.ZERO
var current_location: Node
var starting_orientation: Vector2i = Vector2i.DOWN
var starting_velocity: Vector2i = Vector2i.ZERO

var tilemaps: Array[TileMapLayer] = []
var open_dialogue: bool = false
var open_name_select: bool = false
var current_conflict: ConflictScene = null

func _init() -> void:
	EventBus.set_world(self)
	EventBus.dialogue_started.connect(_on_dialogue_started)
	EventBus.dialogue_ended.connect(_on_dialogue_ended)
	EventBus.win_condition.connect(_on_win_condition)

func _ready() -> void:
	change_location(starting_location, starting_position, starting_orientation, starting_velocity)

func change_location(
	new_location: PackedScene,
	teleport_to_position: Vector2i,
	new_orientation: Vector2i = Vector2i.DOWN,
	new_velocity: Vector2i = Vector2i.ZERO
	) -> void:
	var tween = get_tree().create_tween()
	starting_position = teleport_to_position
	starting_orientation = new_orientation
	starting_velocity = new_velocity
	tween.tween_property(flash, "modulate", Color.WHITE, 0.1)
	if current_location:
		current_location.queue_free()
	tween.tween_property(flash, "modulate", Color.TRANSPARENT, 0.1)
	current_location = new_location.instantiate()
	add_child(current_location)
	tilemaps = []
	for node in current_location.find_children("*", "TileMapLayer"):
		var layer: TileMapLayer = node
		tilemaps.append(layer)

func is_occupied(grid_position: Vector2i) -> bool:
	# comprobamos tilemaps
	for layer in tilemaps:
		var data := layer.get_cell_tile_data(grid_position)
		if not data:
			return true
		if data.get_custom_data("solid"):
			return true
	# comprobamos entidades
	var entities := find_entities_at_position(grid_position)
	for entity in entities:
		if entity.solid:
			return true
	return false

func find_entities_at_position(test_position: Vector2i) -> Array[Entity]:
	var array: Array[Entity] = []
	for node in get_tree().get_nodes_in_group("entity"):
		if node is Entity:
			var entity: Entity = node
			if entity.grid_position == test_position:
				array.append(entity)
	return array

func start_conflict(conflict: Conflict) -> void:
	current_conflict = conflict_scene.instantiate()
	add_child(current_conflict)
	current_conflict.initialize_scene(conflict)

func end_conflict() -> void:
	current_conflict.queue_free()
	current_conflict = null

func display_name_select() -> void:
	var name_select_scene: NameSelectUi = name_select_ui.instantiate()
	open_name_select = true
	add_child(name_select_scene)
	await name_select_scene.menu_closed
	open_name_select = false
	name_select_scene.queue_free()

func is_movement_blocked() -> bool:
	return open_dialogue || open_name_select

#region signals

func _on_dialogue_started() -> void:
	open_dialogue = true

func _on_dialogue_ended() -> void:
	open_dialogue = false

func _on_win_condition() -> void:
	var win = win_condition_scene.instantiate()
	current_location.queue_free()
	add_child(win)
#endregion
