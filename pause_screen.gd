extends Control

@onready var label: Label = $Label
@onready var PauseScreen: Control = $"."
@onready var levelshower = $Label2

var pause = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = $".".PROCESS_MODE_ALWAYS
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pause == false:
		PauseScreen.hide()
	else:
		PauseScreen.show()
		levelshower.text = "You are on level " + str(gamemaster.level) + "."
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start") and gamemaster.alive == true:
		_pause()
	elif gamemaster.alive == false:
		return
	if pause:
		if event.is_action("cancel"):
			get_tree().reload_current_scene()
			
func _pause():
	get_tree().paused = !get_tree().paused 
	if get_tree().paused:
		pause = true
	else:
		pause = false
