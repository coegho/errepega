class_name ConflictScene extends CanvasLayer

@onready var enemy_sprite: TextureRect = %EnemySprite
@onready var player_name: Label = %PlayerName
@onready var enemy_name: Label = %EnemyName
@onready var enemy_state: Label = %EnemyState
@onready var flash_rect: ColorRect = %FlashRect
@onready var root: Control = %Root
@onready var hurt_sound: AudioStreamPlayer = %HurtSound

@export var defeat_dialogue: DialogueResource

var display_health: int = 5

var spoon_points: Array[Node]

func _unhandled_input(event: InputEvent) -> void:
	get_viewport().set_input_as_handled()

func initialize_scene(conflict_data: Conflict) -> void:
	enemy_sprite.texture = conflict_data.enemy_sprite
	enemy_name.text = conflict_data.enemy_name
	enemy_state.text = "(non asinou)"
	player_name.text = PlayerState.player_name
	display_health = PlayerState.player_health
	root.material.set("shader_parameter/grayscale", 0)
	update_health_display()

func _ready() -> void:
	spoon_points = %SpoonBox.get_children()
	PlayerState.harm_received.connect(_on_harm_received)
	PlayerState.player_defeated.connect(_on_player_defeated)
	EventBus.flash_signal.connect(_on_flash_signal)
	EventBus.signature_added.connect(_on_signature_added)
	EventBus.music_requested.emit("battle")

func _on_harm_received() -> void:
	display_health = PlayerState.player_health
	hurt_sound.play()
	update_health_display()

func _on_player_defeated() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(root.material, "shader_parameter/grayscale", 1, 1)
	EventBus.end_all_dialogues.emit()
	DialogueManager.show_dialogue_balloon(defeat_dialogue)

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

func _on_signature_added() -> void:
	enemy_state.text = "(ASINOU)"


func _on_tree_exited() -> void:
	EventBus.music_requested.emit("normal")
