extends CharacterBody2D

var damage: int
var damage_timer: float = 2
var damage_timer_reset: float = 2
var range: float
var throwables = {"banana": 0.6, "bottle": 0.2, "fish": 0.2, "nuke": 0.00001}


@onready var vision = $vision_area

func _physics_process(delta):
	damage_timer -= delta
	
	if damage_timer <= 0:
		throw()
		damage_timer = damage_timer_reset
		
		
func throw():
	spawn_projectile()
	for body in vision.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.queue_free()

func spawn_projectile():
	var projectile = preload("res://entities/components/projectile.tscn")
	var projectile_instance = projectile.instantiate()
	get_parent().add_child(projectile_instance)
	projectile_instance.set_velocity(Vector2(1, 2), 1)
	projectile_instance.global_transform = global_transform
