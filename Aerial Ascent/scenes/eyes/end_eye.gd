extends Area2D

signal can_exit

func _on_body_entered(body):
	if body.name == "player":
		emit_signal("can_exit")
