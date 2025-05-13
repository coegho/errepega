class_name StateVarSetter extends Node2D

@export var var_name: String

func set_var() -> void:
	PlayerState.vars.set(var_name, true)
