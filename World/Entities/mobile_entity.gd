class_name MobileEntity extends Entity

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed: float = 53.333

@export var direction: Vector2i = Vector2i.ZERO
@export var velocity: Vector2i = Vector2i.ZERO
@export var orientation: Vector2i = Vector2i.DOWN

signal step_done


func _physics_process(delta: float) -> void:
	if velocity != Vector2i.ZERO:
		walk_logic(delta)
	else:
		idle_logic()
	

func walk_logic(delta: float) -> void:
	orientation = velocity
	walk_animation()
	var target_position := GridMovement.grid_to_pixel(grid_position)
	global_position = global_position.move_toward(target_position, delta*speed)
	if global_position.is_equal_approx(target_position):
		velocity = Vector2i.ZERO
		step_done.emit()

func idle_logic() -> void:
	if direction != Vector2i.ZERO:
		velocity = direction
		grid_position = grid_position + velocity
		direction = Vector2i.ZERO
	else:
		stand_animation()

func turn_around() -> void:
	orientation = direction

func walk_animation() -> void:
	if orientation == Vector2i.LEFT:
		animation_player.play("walk_left")
	if orientation == Vector2i.RIGHT:
		animation_player.play("walk_right")
	if orientation == Vector2i.UP:
		animation_player.play("walk_up")
	if orientation == Vector2i.DOWN:
		animation_player.play("walk_down")

func stand_animation() -> void:
	if orientation == Vector2i.LEFT:
		animation_player.play("stand_left")
	if orientation == Vector2i.RIGHT:
		animation_player.play("stand_right")
	if orientation == Vector2i.UP:
		animation_player.play("stand_up")
	if orientation == Vector2i.DOWN:
		animation_player.play("stand_down")
