class_name InteractuableEntity extends Entity

signal interacted

func being_interacted() -> void:
	interacted.emit()
