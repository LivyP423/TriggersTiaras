extends Node

var GAME_VERSION = str("0.1.1")

@onready var player = $Princess1
@onready var zombie = %Zombie
@onready var KillCountControl = $Camera2D/GUI/Control
@onready var PauseScreen = $Camera2D/GUI/PauseScreen
@onready var DieScreen = $Camera2D/GUI/DieScreen
@onready var healthbar = $TextureProgressBar
@onready var potion_node = $Potion
@onready var popup_node = %PotionPopup

var level = 1
var score = 0
var kills = 0
var alive = true 		#Player
var playerhealth = 6 
var playerhealthmax = 6
var luck = 5

#NOTE; Level bounds: (-1012,-643), (2513, 1562), (2513,1562), (2513,-643)
#					x difference: x , y difference: x

var min_x = -1012
var max_x = 2513
var min_y = -643
var max_y = 1562


func _ready() -> void:
	randomize()
	alive = true
	playerhealth = 6
	popup_node = get_tree().current_scene.find_child("PotionPopup", true, false)
	
	# 2. Check if BOTH nodes were successfully found before connecting
	if potion_node != null and popup_node != null:
		potion_node.potion_spawned.connect(popup_node._on_potion_spawned)
		print("Successfully connected Potion to PotionPopup!")

				
func spawn_location(min_tile_x, max_tile_x, min_tile_y, max_tile_y) -> Vector2:
	var tile_size = 16
	var random_tile_x = randi_range(-16, 39)
	var random_tile_y = randi_range(-10, 24)
	
	# Center the potion inside the selected tile
	return Vector2(
		(random_tile_x * tile_size) + (tile_size / 2.0),
		(random_tile_y * tile_size) + (tile_size / 2.0)
	)

func spawn(en):
		#  Adds the clone at proper scale to the world scene root
	en.scale = Vector2(1.5, 1.5) 
	en.global_position = spawn_location(min_x,max_x,min_y,max_y)
	#print(str(en.global_position))
	get_tree().current_scene.add_child(en)

func die():
	if not alive:
		return 		#prevents multiple runs 
	alive = false
	var col = get_node_or_null("CollisionShape2D")
	if col:
		col.set_deferred("disabled", true)
		
	if is_instance_valid(player):
		player.queue_free()
	
	if DieScreen:
		DieScreen.show()
		

func reset_player() -> void:
	alive = true
	playerhealth = playerhealthmax
	level = 1
	kills = 0


## TO-DO:
# PRIMARY BUGS:
# When shooting left, bullet comes out beneath the gun
# Pressing a and d at same time has weird gun placement
# Needs continous damage when constantly touching player
# Zombie stuck on player + restricts
# Glitchy movement from zombie
# When restarting on pause screen, must press "enter" before game completely restarts

# IMPROVEMENTS TO MAKE:
# Enemy attention span

# EXPANSIONS:
# New weapons like swords, bombs
# New enemies 
	# Ones with ranged attack
# 
