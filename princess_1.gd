class_name Player
extends CharacterBody2D

@export var max_health = gamemaster.playerhealthmax
@export var speed: float = 300

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var healthbar: TextureProgressBar = $TextureProgressBar
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: CharacterBody2D = $gun
@onready var gunsprite: Sprite2D = $Sprite2D

var current_health = gamemaster.playerhealth
var player: Node2D = null
var can_damage: bool = true

func _ready() -> void:
	gamemaster.reset_player()
	sprite.flip_h = false
	current_health = gamemaster.playerhealth
	if healthbar:
		healthbar.max_value = gamemaster.playerhealth
		healthbar.value = current_health
		
func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("up"):
		direction.y -= 1
		animation.play("walk")
	if Input.is_action_pressed("down"):
		direction.y += 1
		animation.play("walk")
	if Input.is_action_pressed("left"):
		direction.x -= 1
		animation.play("walk")
		sprite.flip_h = true
	if Input.is_action_pressed("right"):
		direction.x += 1	
		animation.play("walk")	
		sprite.flip_h = false
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	velocity = direction * speed
	move_and_slide()
		
	if direction.x < 0:
		gun.position.x = -12
		
	elif direction.x > 0:
		gun.position.x = 12
		
func heal_to_full() -> void:
	gamemaster.playerhealth = gamemaster.playerhealthmax
	current_health = gamemaster.playerhealth
	if healthbar:
		healthbar.value = current_health

func take_damage(damage_amount: int) -> void:
	if !gamemaster.alive:
		return
	
	gamemaster.playerhealth -= damage_amount
	current_health = gamemaster.playerhealth
	if healthbar:
		healthbar.value = gamemaster.playerhealth
		
	if gamemaster.playerhealth <= 0:
		gamemaster.die()
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
