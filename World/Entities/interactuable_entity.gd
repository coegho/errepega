class_name InteractuableEntity extends Entity

@export var dialogue: DialogueResource
@export var dialogue_title: String = ""
@export var delete_after_interact: bool = false

func being_interacted() -> void:
	var dialogue_balloon := DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
	if delete_after_interact:
		await dialogue_balloon.tree_exited
		queue_free()
