extends Node

var coin = 0
var enemy_dead_count = 0
var total_coin = 0
var total_enemy = 0
var player_pos 
var level = 1
var life_count: int = 4:
	set(value):
		life_count = value
		emit_signal("lifecount_changed", life_count)

signal lifecount_changed(new_lifecount)

func reset():
	coin = 0
	enemy_dead_count = 0
	total_coin = 0
	total_enemy = 0
	life_count = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = DisplayServer.screen_get_refresh_rate()
	Engine.physics_ticks_per_second = DisplayServer.screen_get_refresh_rate()
	coin = 0
	enemy_dead_count = 0
