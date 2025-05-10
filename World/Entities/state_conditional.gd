class_name StateConditional extends Node2D

@export var condition_name: StringName
@export var negative: bool

func _ready() -> void:
	if (check_condition() && negative) || \
		(not check_condition() && not negative):
		queue_free()

func check_condition() -> bool:
	return PlayerState.vars.has(condition_name) && \
		PlayerState.vars.get(condition_name) == true
