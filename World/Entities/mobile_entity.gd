class_name MobileEntity extends Entity

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed: float = 53.333

var direction: Vector2i = Vector2i.ZERO
var velocity: Vector2i = Vector2i.ZERO
var orientation: Vector2i = Vector2i.DOWN


func _process(delta: float) -> void:
	direction = Vector2i.ZERO
	if Input.is_action_pressed("move_left"):
		direction = Vector2i.LEFT
	if Input.is_action_pressed("move_right"):
		direction = Vector2i.RIGHT
	if Input.is_action_pressed("move_up"):
		direction = Vector2i.UP
	if Input.is_action_pressed("move_down"):
		direction = Vector2i.DOWN


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
	if global_position == target_position:
		orientation = velocity
		velocity = Vector2i.ZERO

func idle_logic() -> void:
	if direction != Vector2i.ZERO:
		if orientation == direction:
			velocity = direction
			grid_position = grid_position + velocity
		else:
			turn_around()
	else:
		stand_animation()

func turn_around() -> void:
	orientation = direction
	stand_animation()

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


func _on_animation_finished(anim_name: StringName) -> void:
	if velocity == Vector2i.ZERO:
		stand_animation()
