class_name InteractuableEntity extends Entity

@export var dialogue: DialogueResource
@export var dialogue_title: String = ""

func being_interacted() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
