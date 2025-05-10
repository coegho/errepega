class_name Player extends MobileEntity

@onready var turn_around_timer: Timer = $TurnAroundTimer
@onready var bump_timer: Timer = $BumpTimer
var full_stop: bool = true

func _ready() -> void:
	grid_position = world.starting_position
	global_position = GridMovement.grid_to_pixel(grid_position)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		interact()

func _process(delta: float) -> void:
	if world.open_dialogue:
		return
	direction = Vector2i.ZERO
	if Input.is_action_pressed("move_left"):
		direction = Vector2i.LEFT
	if Input.is_action_pressed("move_right"):
		direction = Vector2i.RIGHT
	if Input.is_action_pressed("move_up"):
		direction = Vector2i.UP
	if Input.is_action_pressed("move_down"):
		direction = Vector2i.DOWN

func interact() -> void:
	for entity in find_entities_at_position(grid_position + orientation):
		if entity is InteractuableEntity:
			var interactuable: InteractuableEntity = entity
			interactuable.being_interacted()
			break

func idle_logic() -> void:
	if not bump_timer.is_stopped():
		return
	if direction != Vector2i.ZERO:
		if orientation == direction:
			if not turn_around_timer.is_stopped(): #se foi un xiro agardamos un chisco
				return
			if not world.is_occupied(grid_position + direction):
				full_stop = false
				velocity = direction
				grid_position = grid_position + velocity
			else:
				bump_timer.start()
				velocity = direction
		else:
			turn_around()
	else:
		full_stop = true
		stand_animation()

func turn_around() -> void:
	if full_stop:
		turn_around_timer.start()
	orientation = direction


func _on_step_done(final_position: Vector2i) -> void:
	var entities := find_entities_at_position(final_position)
	for entity in entities:
		if entity is DoorEntity:
			world.change_location(entity.new_location, entity.starting_position)
