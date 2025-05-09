class_name Entity extends Node2D

var grid_position: Vector2i
var world: World

func _ready() -> void:
	grid_position = GridMovement.pixel_to_grid(global_position)
	world = EventBus.get_world()
	add_to_group("entity")

func find_entities_at_position(test_position: Vector2i) -> Array[Entity]:
	var array: Array[Entity] = []
	for node in get_tree().get_nodes_in_group("entity"):
		if node is Entity:
			var entity: Entity = node
			if entity.grid_position == test_position:
				array.append(entity)
	return array
