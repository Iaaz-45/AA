extends Node2D

@onready var player = get_parent().get_node("player")
var exit_level = false
var can_exit = false

func _on_level_1_open_door():
	exit_level = true
	print("true")

func _process(delta):
	if exit_level == true and player.exit == true and can_exit:
		get_tree().quit()


func _on_area_2d_body_entered(body):
	if body.name == "player":
		can_exit = true
		print("enter")


func _on_area_2d_body_exited(body):
	if body.name == "player":
		can_exit = false
		print("exit")
