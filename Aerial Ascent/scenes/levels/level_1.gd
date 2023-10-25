extends Node2D

signal open_door

@onready var player = $player
@onready var start = $Start
@onready var end = $End

func _ready():
	player.position = start.position
	

func _on_end_eye_can_exit():
	emit_signal("open_door")
