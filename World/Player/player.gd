class_name Player extends MobileEntity

@onready var turn_around_timer: Timer = $TurnAroundTimer
@onready var bump_timer: Timer = $BumpTimer

var full_stop: bool = true
var frozen: bool = false

func _ready() -> void:
	global_position = GridMovement.grid_to_pixel(world.starting_position)
	grid_position = world.starting_position + world.starting_velocity
	orientation = world.starting_orientation
	velocity = world.starting_velocity
	stand_animation()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		interact()

func _process(_delta: float) -> void:
	direction = Vector2i.ZERO
	if frozen || world.is_movement_blocked():
		return
	if Input.is_action_pressed("move_left"):
		direction = Vector2i.LEFT
	if Input.is_action_pressed("move_right"):
		direction = Vector2i.RIGHT
	if Input.is_action_pressed("move_up"):
		direction = Vector2i.UP
	if Input.is_action_pressed("move_down"):
		direction = Vector2i.DOWN

func interact() -> void:
	for entity in world.find_entities_at_position(grid_position + orientation):
		if entity.has_method("being_interacted"):
			entity.being_interacted(self)
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


func _on_step_done() -> void:
	var entities := get_tree().get_nodes_in_group("entity")
	for entity in entities:
		if entity is DoorEntity && entity.grid_position == grid_position:
			var new_location = ContentLoader.load_location(entity.new_location_name)
			world.change_location(new_location, entity.starting_position, orientation, entity.starting_velocity)
		if entity is NpcEntity:
			if entity.player_on_range(grid_position):
				frozen = true
				await entity.trigger_player_chase(self)
				orientation = entity.grid_position - grid_position
				frozen = false
				interact()
