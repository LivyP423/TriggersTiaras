class_name Enemy
extends CharacterBody2D

var HEALTH: int = 3
var hurt: bool = false
var speed: float = 100
var damage: int = 1
var index: int = 0
var is_dead: bool = false
var attack_range: int = 5

enum State {PATROL, CHASE}
var state := State.PATROL

var player: Node2D = null
var killcount_ui: Control = null
#var active_player: Node2D = null

@onready var animation = $AnimatedSprite2D
@onready var healthbar = $TextureProgressBar
@onready var stop_distance: float = 24.0
@onready var playerhitbox: Area2D = $Area2D
@onready var attentionspan: Timer = $AttentionSpan

@export var detect_range: float = 275.0

func _ready() -> void:
	HEALTH = 3
	if healthbar:
		healthbar.max_value = 3
		healthbar.value = HEALTH
	hurt = false
	if not is_instance_valid(player):
		player = get_tree().current_scene.find_child("Princess1", true, false) as Node2D

func _physics_process(delta: float) -> void:
	if player == null:
		return
	if HEALTH < 3:
		hurt = true
		if animation: animation.play("hurtwalk")
	else:
		hurt = false
		if animation: animation.play("walk")

	if hurt:
		speed = 125
	else:
		speed = 100.0
		
	if not is_instance_valid(player):
		# Safe fallback: find Princess1 automatically if not set by spawner
		player = get_tree().current_scene.find_child("Princess1", true, false) as Node2D
				
	if global_position.distance_to(player.global_position) > stop_distance:
		velocity = global_position.direction_to(player.global_position) * speed
		move_and_slide()	
	else:
		velocity = Vector2.ZERO
		
	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player > attack_range:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		
func take_enemy_damage(_damage_amount):
	if is_dead:
		return
	HEALTH -= 1
	if healthbar:
		healthbar.value = HEALTH
	if HEALTH <= 0:
		is_dead = true
		gamemaster.kills += 1
		if is_instance_valid(killcount_ui) and killcount_ui.has_method("add_kill"):
			killcount_ui.add_kill(gamemaster.kills)
		die()

func player_in_range() -> bool:
	if not is_instance_valid(player):
		return false
	return global_position.distance_to(player.global_position) < detect_range
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
	else:
		pass		
func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Player:
		body.take_damage(0)
		
func die():
	self.queue_free()
