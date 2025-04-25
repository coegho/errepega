extends Node

@export var dialogue: DialogueResource

func interacted() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)
