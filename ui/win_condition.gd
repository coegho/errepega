extends CanvasLayer

func _ready() -> void:
	%Button.grab_focus()

func _on_button_pressed() -> void:
	EventBus.back_to_menu.emit()
