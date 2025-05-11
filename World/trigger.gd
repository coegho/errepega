class_name Trigger extends Node

@export var dialogue: DialogueResource
@export var dialogue_title: String = ""

func _ready() -> void:
	var dialogue_balloon := DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
