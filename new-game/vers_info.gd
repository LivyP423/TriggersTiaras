extends Control

@onready var label = $Label

func _ready() -> void:
	label.text = "Vers. " + gamemaster.GAME_VERSION
