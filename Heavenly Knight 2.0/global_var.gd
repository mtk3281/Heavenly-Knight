extends Node

var coin = 0
var enemy_dead_count = 0
var total_coin = 0
var total_enemy = 0
var player_pos 

var life_count: int = 4:
	set(value):
		life_count = value
		emit_signal("lifecount_changed", life_count)

signal lifecount_changed(new_lifecount)

# Called when the node enters the scene tree for the first time.
func _ready():
	coin = 0
	enemy_dead_count = 0
