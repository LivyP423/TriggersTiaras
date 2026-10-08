#NOTE: THIS SPAWNER IS FOR ZOMBIES ONLY!! SCARED TO RENAME, IT MAY BREAK IT!
extends Node2D

@onready var enemy = preload("res://zombie.tscn")
#@onready var potion = preload("res://potion.tscn")


var min_x = gamemaster.min_x  
var max_x = gamemaster.max_x
var min_y = gamemaster.min_y
var max_y = gamemaster.max_y


# spawner.gd
func _on_timer_timeout() -> void:
	var en = enemy.instantiate()
	if en == null:
		return

	# Pass reference directly from gamemaster instead of navigating relative paths
	if is_instance_valid(gamemaster.KillCountControl):
		en.killcount_ui = gamemaster.KillCountControl
		
	gamemaster.spawn(en)
