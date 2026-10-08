extends CharacterBody2D

@onready var shoot_raycast = $RayCast2D
@onready var Muzzle = $RayCast2D/Muzzle
@onready var sprite = $Sprite2D

const RAY_DISTANCE = 1400
const Bullet = preload("res://bullet.tscn")

func _physics_process(delta: float) -> void:
	if not gamemaster.alive:
		return
	if Input.is_action_just_pressed("shoot"):
		if shoot_raycast.is_colliding():
			var collider = shoot_raycast.get_collider()
			if collider.has_method("take_enemy_damage"):
					collider.take_enemy_damage(1)
		shoot()
	if Input.is_action_pressed("left"):
		sprite.flip_v = true
		rotation_degrees = 180
	if Input.is_action_pressed("right"):
		sprite.flip_v = false
		rotation_degrees = 0
		
func shoot() -> void:
	var b = Bullet.instantiate()
	var spawn_node = owner if owner else get_parent()
	spawn_node.add_child(b)
	b.global_transform = Muzzle.global_transform
