class_name Player extends MobileEntity

@onready var turn_around_timer: Timer = $TurnAroundTimer
var full_stop: bool = true


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		interact()

func interact() -> void:
	for entity in find_entities_at_position(grid_position + orientation):
		if entity is InteractuableEntity:
			var interactuable: InteractuableEntity = entity
			print_debug(entity.name)
			break

func idle_logic() -> void:
	if direction != Vector2i.ZERO:
		if orientation == direction:
			if turn_around_timer.is_stopped(): #se foi un xiro agardamos un chisco
				full_stop = false
				velocity = direction
				grid_position = grid_position + velocity
		else:
			turn_around()
	else:
		full_stop = true
		stand_animation()

func turn_around() -> void:
	if full_stop:
		turn_around_timer.start()
	orientation = direction
	stand_animation()
