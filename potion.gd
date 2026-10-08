class_name Collectibles
extends Node2D

signal potion_spawned

var active_clone: Node = null
@export var potion_scene: PackedScene = preload("res://potion.tscn")


func _on_potion_collected(body: Node2D, potion_node: Node2D) -> void: 
	if body is Player:
		print("You got it!")
		body.heal_to_full()
		
		potion_node.queue_free()
		active_clone = null  # Clear out so another one can spawn later

func lucky(): 
	# Safely check if a potion is already present in the level
	if is_instance_valid(active_clone):
		return
		
	var i = randi_range(0, 50)
	if i <= gamemaster.luck:
		print("GOOD LUCK")
		var clone = potion_scene.instantiate() as Node2D 
		active_clone = clone
		
		var random_location = gamemaster.spawn_location(-16, 39, -10, 24)
		clone.global_position = random_location
		clone.scale = Vector2(6.7, 6.7)
		clone.visible = true
		clone.modulate = Color("fb72d1")
		
		var clone_timer = clone.get_node_or_null("Timer")
		if clone_timer:
			clone_timer.queue_free()
		
		var area = clone.get_node_or_null("Area2D") as Area2D
		if area:
			# FIX: Using an inline Lambda function completely bypasses Godot's binding limits 
			# and safely passes both variables without breaking signatures!
			area.body_entered.connect(func(body): 
				_on_potion_collected(body, clone)
			)
		
		get_tree().current_scene.add_child(clone)
		print("Potion spawned at: ", random_location)
		
		# Now this line is guaranteed to trigger every single time!
		potion_spawned.emit()

func _on_timer_timeout() -> void:
	lucky()
