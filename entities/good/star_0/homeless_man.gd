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
	var selected_throwable = pick_random_throwable()
	print("picked throwable: ", selected_throwable)
	spawn_projectile(selected_throwable)
	for body in vision.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.queue_free()

func pick_random_throwable() -> String:
	var total_chance = 0.0
	for chance in throwables.values():
		total_chance += chance
		
	var random_value = randf() * total_chance
	var cumulative_chance = 0.0
	
	for throwable in throwables.keys():
		cumulative_chance += throwables[throwable]
		if random_value <= cumulative_chance:
			return throwable
			
	# In case of error, default to the first throwable (banana)
	return throwables.keys()[0]

func spawn_projectile(throwable):
	var projectile = preload("res://entities/components/projectile.tscn")
	var projectile_instance = projectile.instantiate()
	get_parent().add_child(projectile_instance)
	projectile_instance.set_velocity(Vector2(1, 2), 1)
	projectile_instance.global_transform = global_transform
