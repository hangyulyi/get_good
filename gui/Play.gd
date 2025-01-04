# MobTimer: every mob spawn (20 mobs should take 20 seconds (may adjust))
# SpawnTimer: every new level spawn (longer than the time it takes for MobTimer to take)

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$SpawnTimer.stop()
	$MobTimer.stop()
	
func new_game():
	$StartTimer.start()
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$SpawnTimer.start()
