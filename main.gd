extends Node2D

@onready var main_menu = %MainMenu
@export var world_scene: PackedScene
@export var main_menu_scene: PackedScene

var world: World

func _ready() -> void:
	EventBus.back_to_menu.connect(_on_back_to_menu)
	main_menu.start_game.connect(_on_main_menu_start_game)

func _on_main_menu_start_game() -> void:
	main_menu.queue_free()
	world = world_scene.instantiate()
	add_child(world)

func _on_back_to_menu() -> void:
	if world:
		world.queue_free()
	main_menu = main_menu_scene.instantiate()
	add_child(main_menu)
	main_menu.start_game.connect(_on_main_menu_start_game)
