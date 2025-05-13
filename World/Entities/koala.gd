extends InteractuableEntity

func _ready() -> void:
	update_grid_position()
	interaction_ended.connect(_on_interaction_ended)
	if PlayerState.vars.get("koala_" + name):
		queue_free()

func _on_interaction_ended(player: Player) -> void:
	PlayerState.vars.set("koala_" + name, true)
	queue_free()
