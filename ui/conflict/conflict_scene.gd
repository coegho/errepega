class_name ConflictScene extends CanvasLayer

@onready var enemy_sprite: TextureRect = %EnemySprite
@onready var player_name: Label = %PlayerName
@onready var enemy_name: Label = %EnemyName
@onready var flash_rect: ColorRect = %FlashRect

var display_health: int = 5

var spoon_points: Array[Node]

func _unhandled_input(event: InputEvent) -> void:
	get_viewport().set_input_as_handled()

func initialize_scene(conflict_data: Conflict) -> void:
	enemy_sprite.texture = conflict_data.enemy_sprite
	enemy_name.text = conflict_data.enemy_name
	player_name.text = PlayerState.player_name
	display_health = PlayerState.player_health
	update_health_display()

func _ready() -> void:
	spoon_points = %SpoonBox.get_children()
	PlayerState.harm_received.connect(_on_harm_received)
	EventBus.flash_signal.connect(_on_flash_signal)

func _on_harm_received() -> void:
	display_health = PlayerState.player_health
	update_health_display()

func _on_flash_signal() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(flash_rect, "modulate", Color.WHITE, 0.1)
	tween.tween_property(flash_rect, "modulate", Color.TRANSPARENT, 0.1)
	tween.tween_property(flash_rect, "modulate", Color.WHITE, 0.1)
	tween.tween_property(flash_rect, "modulate", Color.TRANSPARENT, 0.1)
	tween.tween_property(flash_rect, "modulate", Color.WHITE, 0.1)
	tween.tween_property(flash_rect, "modulate", Color.TRANSPARENT, 0.1)

func update_health_display() -> void:
	for i in range(spoon_points.size()):
		spoon_points[i].visible = (i < display_health)
