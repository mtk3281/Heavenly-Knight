extends Node2D

const SPEED = 565
var direction = -1
var velocity = Vector2()

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
