extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category("Basics")
@export var SPEED = 80.0
@export_enum("left:-1","right:1") var direction : int
@export var detect_cliffs = true


func _ready():
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
		$floor_checker.position.x *= -1
	if not detect_cliffs:
		set_modulate(Color(1.2,0.5,1.0))
	$floor_checker.enabled = detect_cliffs
	
func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and not $floor_checker.is_colliding() and detect_cliffs:
		$floor_checker.position.x *= -1
		direction *= -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		
	velocity.x = direction * SPEED
	move_and_slide()


func _on_top_body_entered(body):
	if body.name == "Steve":
		$AnimatedSprite2D.play("squash")
		SPEED = 0
		
		maskoff()
		$Timer.start()
#		body.bounce()

func maskoff():
	$top.set_collision_layer_value(4,false)
	$top.set_collision_mask_value(1,false)
	$side.set_collision_mask_value(1,false)
	set_collision_layer_value(4,false)
	set_collision_mask_value(1,false)

func _on_side_body_entered(body):
	if body.name == "Steve":
		SPEED = 0
		maskoff()
		body.ouch(position.x)
		$Timer.start()

func die():
	$AnimatedSprite2D.flip_v = true
	SPEED = 0
	maskoff()
	$AnimationPlayer.play("died")
	$Timer.start()


func _on_timer_timeout():
	GlobalVar.enemy_dead_count += 1
	queue_free()
