extends Area2D


func _on_body_entered(body):
	if body.name == "Steve":
		$AnimationPlayer.play("flip")

func _on_animation_player_animation_finished(_anim_name):
	GlobalVar.coin += 1
	queue_free()
