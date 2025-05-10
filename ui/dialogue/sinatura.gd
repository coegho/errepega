class_name NameSelectUi extends CanvasLayer

@export var success_dialogue: DialogueResource

@onready var sprite1: Sprite2D = %SpriteNome
@onready var sprite2: Sprite2D = %SpriteConcello
@onready var sprite3: Sprite2D = %SpriteXenero
@onready var sprite4: Sprite2D = %SpriteRematar

@onready var nomeInput: LineEdit = %NomeInput
@onready var concelloInput: LineEdit = %ConcelloInput
@onready var xeneroHomeInput: CheckBox = %XeneroHomeInput
@onready var xeneroMullerInput: CheckBox = %XeneroMullerInput
@onready var xeneroNbInput: CheckBox = %XeneroNbInput
@onready var xeneroInput: ButtonGroup = xeneroHomeInput.button_group
@onready var rematarBtn: Button = %RematarButton

signal menu_closed

func _unhandled_input(event: InputEvent) -> void:
	get_viewport().set_input_as_handled()

func _ready() -> void:
	nomeInput.grab_focus()

func _on_nome_input_focus_entered() -> void:
	hide_sprites()
	sprite1.visible = true


func _on_concello_input_focus_entered() -> void:
	hide_sprites()
	sprite2.visible = true


func _on_xenero_input_focus_entered() -> void:
	hide_sprites()
	sprite3.visible = true

func _on_rematar_button_focus_entered() -> void:
	hide_sprites()
	sprite4.visible = true

func hide_sprites() -> void:
	sprite1.visible = false
	sprite2.visible = false
	sprite3.visible = false
	sprite4.visible = false

func isInputValid() -> bool:
	return nomeInput.text.length() > 0 \
		&& concelloInput.text.length() > 0 \
		&& xeneroInput.get_pressed_button() != null

func validateInput() -> void:
	rematarBtn.disabled = ! isInputValid()


func _on_nome_input_text_changed(new_text: String) -> void:
	validateInput()


func _on_concello_input_text_changed(new_text: String) -> void:
	validateInput()


func _on_xenero_input_pressed() -> void:
	validateInput()


func _on_rematar_button_pressed() -> void:
	PlayerState.player_name = nomeInput.text
	PlayerState.concello_name = concelloInput.text
	if xeneroInput.get_pressed_button() == xeneroHomeInput:
		PlayerState.player_pronoun = PlayerState.EL
	if xeneroInput.get_pressed_button() == xeneroMullerInput:
		PlayerState.player_pronoun = PlayerState.ELA
	if xeneroInput.get_pressed_button() == xeneroNbInput:
		PlayerState.player_pronoun = PlayerState.ELI
	PlayerState.vars.set("name_selected", true)
	DialogueManager.show_dialogue_balloon(success_dialogue)
	menu_closed.emit()
