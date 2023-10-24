extends Node2D

@onready var player = $player
@onready var start = $Start

func _ready():
	player.position = start.position
	
