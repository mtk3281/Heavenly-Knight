extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
#
#	if Input.is_action_pressed("jump") and not is_on_floor():
#		$Sprite2D.play("air")
	
	
	direction = Input.get_axis("left", "right")
	if direction:
		if is_on_floor():
			$Sprite2D.play("walk")
		if direction == 1:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true

		velocity.x = direction * SPEED
	else:
		
		if is_on_floor():
			$Sprite2D.play("idle")
		else:
			$Sprite2D.play("air")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_fallzone_body_entered(body):
	if body.name == "Steve":
		get_tree().change_scene_to_file("res://level_1.tscn")
		dead()
		
func dead():
	print("dead")
