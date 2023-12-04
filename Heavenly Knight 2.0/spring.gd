extends Node2D


func _on_area_2d_body_entered(body):
	print(body)
	if body.name =="Steve":
		$StaticBody2D/AnimatedSprite2D.play("spring")
		body.bounce(2)


func _on_visible_on_screen_notifier_2d_screen_exited():
	$StaticBody2D/AnimatedSprite2D.stop()

