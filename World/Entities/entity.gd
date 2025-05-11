class_name Entity extends Node2D

@export var solid: bool = false

var grid_position: Vector2i
var world: World

func _init() -> void:
	world = EventBus.get_world()
	add_to_group("entity")

func _ready() -> void:
	update_grid_position()

func update_grid_position() -> void:
	grid_position = GridMovement.pixel_to_grid(global_position)
