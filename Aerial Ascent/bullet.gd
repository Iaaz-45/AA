extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(_delta):
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "player":
		get_tree().quit()
		
	if velocity == Vector2.ZERO:
		$AudioStreamPlayer2D.playing = true
		visible = false
		$Timer.start(0.2)



func _on_timer_timeout():
	queue_free()
