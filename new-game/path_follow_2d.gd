extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var speed = 0.1

func _process(delta: float):
	progress_ratio += delta * speed
