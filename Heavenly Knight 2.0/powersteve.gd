extends CharacterBody2D

const FIREBALL = preload("fireball.tscn")

@export var SPEED = 750
@export var RUN_SPEED = 750
@export var JUMP_VELOCITY = -1000.0

const ACC = 300
const FRICTION = 380

const MAX_JUMP = 4

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_count = 1
var dead = false



func _physics_process(delta):
	if $Sprite2D.get_playing_speed() != 1.0:
		$Sprite2D.set_speed_scale(1.0)
		
	## Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if not is_on_floor():
		$Sprite2D.play("air")
#
	#jump implementation
	if is_on_floor() and jump_count != 0:
		jump_count = 0
	if jump_count < MAX_JUMP:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			jump_count += 1
	if is_on_wall():
		jump_count = 0
	
	var direction = Input.get_axis("left","right")
	if direction:
		
		if is_on_floor():
			if  not dead:
				$Sprite2D.play("walk")
		if direction == 1:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		if Input.is_action_pressed("run"):
			var target_velocity = Vector2(RUN_SPEED * direction, velocity.y)
			velocity = velocity.move_toward(target_velocity, ACC)
			$Sprite2D.set_speed_scale(2.0)
		else:
			var target_velocity = Vector2(SPEED * direction, velocity.y)
			velocity = velocity.move_toward(target_velocity, ACC)
	else:
		if not dead:
			if is_on_floor():
				$Sprite2D.play("idle")
			else:
				$Sprite2D.play("air")
		var target_velocity = Vector2(0, velocity.y)
		velocity = velocity.move_toward(target_velocity, FRICTION)
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		var dir = 1 if not $Sprite2D.flip_h else -1
		var FireInst = FIREBALL.instantiate()
		FireInst.global_position = global_position
		
		FireInst.position.x = global_position.x + (50 * dir)
		FireInst.position.y = global_position.y+20

		FireInst.direction = dir
		get_parent().add_child(FireInst)


func _on_area_2d_body_entered(body):
	#body.die()
	pass


func ouch(pos):
	pass
