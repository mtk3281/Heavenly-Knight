extends CharacterBody2D


@export var SPEED = 400
@export var JUMP_VELOCITY = -800.0
@export_range(0.0, 1.0) var FRICTION = 0.1
@export_range(0.0 , 1.0) var ACC = 0.20
#const ACC = 125
#const FRICTION = 160

const MAX_JUMP = 2

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_count = 1
var dead = false
var checkpoint


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if not is_on_floor():
		$Sprite2D.play("air")

	#jump implementation
	if is_on_floor() and jump_count != 0:
		jump_count = 0
	if jump_count < MAX_JUMP:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			jump_count += 1
	
	var direction = Input.get_axis("left","right")
	
	if direction:
		if is_on_floor():
			if  not dead:
				$Sprite2D.play("walk")
		if direction == 1:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true

		velocity.x = lerp(velocity.x, direction * SPEED, ACC)
	else:
		if not dead:
			if is_on_floor():
				$Sprite2D.play("idle")
			else:
				$Sprite2D.play("air")
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
	move_and_slide()



func _on_fallzone_body_entered(body):
	if body.name == "Steve":
		get_tree().change_scene_to_file("res://level_1.tscn")

func bounce():
	velocity.y = 0.7 * JUMP_VELOCITY
	
func ouch(pos):
	dead = true
	set_modulate(Color(1.0,0.3,0.3,0.3))
	$Sprite2D.play("crouch")
	
	if position.x < pos:
		velocity.x = -1800
	elif position.x > pos:
		velocity.x = 1800
	$Timer.start()
	Input.action_release("left")
	Input.action_release("right")
	Input.action_release("jump")
	
	


func _on_timer_timeout():
	queue_free()
	GlobalVar.life_count -= 1
	get_tree().change_scene_to_file("res://level_1.tscn")
	
