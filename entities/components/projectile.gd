extends RigidBody2D

var damage: int

func set_velocity(direction:Vector2, speed):
	linear_velocity = direction * speed


func _on_area_2d_body_entered(body):
	body.health -= damage
	queue_free()
