extends CharacterBody2D

const FIREBALL = preload("fireball.tscn")

@export var SPEED = 550
@export var RUN_SPEED = 650
@export var JUMP_VELOCITY = -800.0

const ACC = 250
const FRICTION = 280

const MAX_JUMP = 2

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_count = 1
var dead = false
var checkpoint

func _ready():
	GlobalVar.player_pos = global_position
	GlobalVar.total_coin =len(get_tree().get_nodes_in_group("Coins"))
	GlobalVar.total_enemy =len(get_tree().get_nodes_in_group("Enemies"))	
	GlobalVar.coin = 0
	GlobalVar.enemy_dead_count = 0


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


func _on_fallzone_body_entered(body):
	if body.name == "Steve":
		GlobalVar.life_count -= 1
		global_position = GlobalVar.player_pos
		if GlobalVar.life_count ==0:
			Input.action_release("left")
			Input.action_release("right")
			Input.action_release("jump")
			$Timer.start()

#called in enemy script
func bounce(val=1):
	velocity.y = 0.7 * JUMP_VELOCITY * val
	
func ouch(pos):
#	dead = true
	velocity.y = -350
	GlobalVar.life_count -= 1
	if GlobalVar.life_count ==0:
		$Sprite2D.play("crouch")
		set_modulate(Color(1.0,0.3,0.3,0.3))
		Input.action_release("left")
		Input.action_release("right")
		Input.action_release("jump")
		$Timer.start()

	if is_on_floor():
		global_position = GlobalVar.player_pos
		if $Sprite2D.flip_h:
			$Sprite2D.flip_h = false
	
	
func _on_timer_timeout():
	GlobalVar.reset()
	get_tree().change_scene_to_file("res://level_"+str(GlobalVar.level)+".tscn")
