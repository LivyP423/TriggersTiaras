extends TextureRect

@onready var bottomleft = $"."
@onready var topleft = $"../TextureRect2"
@onready var bottomright = $"../TextureRect3"
@onready var topright =$"../TextureRect4"

func _ready() -> void:
	print("bottom left: " + str(bottomleft.global_position))
	print("top left: " + str(topleft.global_position))
	print("bottom right: " + str(bottomright.global_position))
	print("top right: " + str(topright.global_position))
