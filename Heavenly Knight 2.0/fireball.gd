extends CharacterBody2D

const SPEED = 565
var direction = -1

#func _ready():
#	velocity = SPEED * direction

func _physics_process(delta):
	velocity.x = direction * SPEED
	move_and_slide()
	
	if is_on_wall() or is_on_ceiling():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.get_collision_layer()==8:
		body.die()
		queue_free()
