extends Node2D


func _on_area_2d_body_entered(body):
	if body.name == "Steve":
		$AnimatedSprite2D.play("checkpoint")
		body.update_checkpoint()
