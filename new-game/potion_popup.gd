extends Control

@onready var popup = $"."
@onready var potion = $"."
@onready var texture = $NinePatchRect/TextureRect

func _ready() -> void:
	popup.hide()

func _physics_process(delta: float) -> void:
	pass

func _on_potion_spawned():
	visible = true
	await get_tree().create_timer(3.0).timeout
	visible = false
	texture.modulate = Color("fb72d1")
