extends Node

enum {
	EL, ELA, ELI
}

var player_name: String = "CAMARADA"
var concello_name: String = "LOURIDO"
var player_pronoun: int = ELI
var player_health: int = 5

var vars: Dictionary[String, Variant] = {}
var signatures: Array[String] = []

signal player_defeated
signal harm_received

func suffer_harm() -> void:
	player_health = player_health - 1
	harm_received.emit()
	if player_health <= 0:
		player_defeated.emit()

func restore_health() -> void:
	player_health = 5
