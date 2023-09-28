extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category("Basics")
@export var SPEED = 70.0
@export_enum("left:-1","right:1") var direction : int
@export var detect_cliffs = true


func _ready():
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
		$floor_checker.position.x *= -1
		
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
