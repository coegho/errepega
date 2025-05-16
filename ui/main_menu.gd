extends CanvasLayer

@onready var menu: Control = %Menu
@onready var credits: Control = %Credits
@onready var start_button: Button = %StartButton
@onready var credits_button: Button = %CreditsButton
@onready var back_button: Button = %BackButton

signal start_game

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	start_game.emit()


func _on_credits_button_pressed() -> void:
	menu.visible = false
	credits.visible = true
	back_button.grab_focus()


func _on_back_button_pressed() -> void:
	credits.visible = false
	menu.visible = true
	credits_button.grab_focus()
