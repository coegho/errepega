class_name ConflictScene extends CanvasLayer

@onready var enemy_sprite: TextureRect = %EnemySprite
@onready var player_name: Label = %PlayerName
@onready var enemy_name: Label = %EnemyName

func _unhandled_input(event: InputEvent) -> void:
	get_viewport().set_input_as_handled()

func initialize_scene(conflict_data: Conflict) -> void:
	enemy_sprite.texture = conflict_data.enemy_sprite
	enemy_name.text = conflict_data.enemy_name
	player_name.text = PlayerState.player_name
