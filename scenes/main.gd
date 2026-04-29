extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = player_scene.instantiate()
	$TestRoom.add_child(player)
	player.global_position = $TestRoom/SpawnPlayer.global_position

	print("Spawn:", player.global_position)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
