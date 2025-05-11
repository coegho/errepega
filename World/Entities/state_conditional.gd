class_name StateConditional extends Node2D

@export var condition_name: StringName

signal condition_passed
signal condition_failed

func _ready() -> void:
	if check_condition():
		condition_passed.emit()
	else:
		condition_failed.emit()

func check_condition() -> bool:
	return PlayerState.vars.has(condition_name) && \
		PlayerState.vars.get(condition_name) == true
