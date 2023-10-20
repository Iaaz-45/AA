extends CharacterBody2D

func _physics_process(_delta):
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "player":
		get_tree().quit()
		
	if velocity == Vector2.ZERO:
		queue_free()

