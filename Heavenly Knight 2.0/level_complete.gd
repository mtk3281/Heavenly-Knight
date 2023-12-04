extends Node2D

func _ready():
	$Control/CoinLabel.visible = false
	$Control/EnemyLabel.visible = false

func _on_area_2d_body_entered(body):
	if body.name == "Steve":
		if GlobalVar.enemy_dead_count != GlobalVar.total_enemy:
			$Control/EnemyLabel.visible = true
		elif GlobalVar.coin != GlobalVar.total_coin:
			$Control/CoinLabel.visible = true
		else:
			$AnimatedSprite2D.play("flag")
			$Timer.start()


func _on_timer_timeout():
	GlobalVar.level += 1
	
	GlobalVar.reset()
	get_tree().change_scene_to_file("res://level_"+str(GlobalVar.level)+".tscn")


func _on_area_2d_body_exited(body):
	if body.name == "Steve":
		$Control/CoinLabel.visible = false
		$Control/EnemyLabel.visible = false
