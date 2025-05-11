class_name InteractuableEntity extends Entity

@export var dialogue: DialogueResource
@export var dialogue_title: String = ""
@export var delete_after_interact: bool = false

signal interaction_started(player: Player)
signal interaction_ended(player: Player)

func being_interacted(player: Player) -> void:
	interaction_started.emit(player)
	var dialogue_balloon := DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
	await dialogue_balloon.tree_exited
	interaction_ended.emit(player)
	if delete_after_interact:
		queue_free()
