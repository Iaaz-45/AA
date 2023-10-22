extends StaticBody2D

@onready var bullet_spawner = $bullet_spawner
@export var rotate = 0
@onready var rotation_d = global_rotation_degrees
var speed = 2000
var BULLET = preload("res://scenes/bullet.tscn")

func _on_timer_timeout():
	$AnimationPlayer.play("shoot")
	$AudioStreamPlayer2D.playing = true
	
	var bullet = BULLET.instantiate()
	bullet_spawner.add_child(bullet)
	
	global_rotation_degrees = rotate
	
	bullet.position.x = 48
	if rotation_d == 0:
		bullet.velocity.x = speed
	elif rotation_d == 90:
		bullet.velocity.y = speed
	elif rotation_d == -90:
		bullet.velocity.y = -speed
	elif rotation_d == 180:
		bullet.velocity.x = -speed
		


