extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -800.0

#@onready player
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction
var dead = false
var start_pos
var checkpoint


func _ready():
	start_pos = position

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	direction = Input.get_axis("left", "right")
	if direction:
		if is_on_floor():
			if  not dead:
				$Sprite2D.play("walk")
		if direction == 1:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true

		velocity.x = direction * SPEED
	else:
		if not dead:
			if is_on_floor():
				$Sprite2D.play("idle")
			else:
				$Sprite2D.play("air")
		velocity.x = move_toward(velocity.x, 0, SPEED)
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
	
