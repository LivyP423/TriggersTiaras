extends Control

@onready var diescreen = $"."
@onready var scoreshower = $Label2
@onready var levelshower = $Label3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diescreen.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gamemaster.alive == true:
		diescreen.hide()
	if gamemaster.alive == false:
		diescreen.show()
		scoreshower.text = "YOUR SCORE: " + str(gamemaster.kills)
		levelshower.text = "YOUR LEVEL: " + str(gamemaster.level)
		if Input.is_action_pressed("start"):
			get_tree().reload_current_scene()
