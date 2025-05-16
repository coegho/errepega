class_name NpcEntity extends MobileEntity

@onready var interactuable: InteractuableEntity = $InteractuableEntity
@onready var sprite: Sprite2D = $Sprite2D
@onready var exclamation_anim: AnimationPlayer = $ExclamationAnimationPlayer

@export var turn_when_interacted: bool = true
@export var vision_range: int = 0

@export var dialogue: DialogueResource
@export var dialogue_title: String = "start"
@export var sprite_texture: Texture2D
@export var passed_var: String

func _ready() -> void:
	update_grid_position()
	interactuable.dialogue = dialogue
	interactuable.dialogue_title = dialogue_title
	sprite.texture = sprite_texture
	if passed_var && PlayerState.vars.get(passed_var):
		disable_range_vision()

func _on_interaction_started(player: Player) -> void:
	if turn_when_interacted:
		disable_range_vision()
		orientation = (player.grid_position - grid_position)

func player_on_range(player_position: Vector2i) -> bool:
	for i in range(vision_range):
		var distance: int = i + 1
		if grid_position + orientation * distance == player_position:
			return true
	return false

func trigger_player_chase(player: Player) -> void:
	disable_range_vision()
	exclamation_anim.play("exclamation")
	await exclamation_anim.animation_finished
	while (player.grid_position - grid_position).length() > 1:
		direction = orientation
		await step_done
	return

func disable_range_vision() -> void:
	vision_range = 0
