extends CharacterBody2D

@export_category("Basics")
@export var SPEED = 80
var ACC = 10
@onready var gravity = 0
@export var direction = 1

var chase = false
var player = null

func _ready():
	$AnimatedSprite2D.play("fly")

func _physics_process(delta):
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		direction = direction * -1

	velocity.y += gravity
	velocity.x = direction * SPEED
	
	if chase:
		SPEED = 160
		velocity = position.direction_to(player.position) * SPEED
	
	move_and_slide()


func die():
	chase = false
	$AnimationPlayer.play("died")
	GlobalVar.enemy_dead_count += 1

func _on_detection_area_body_entered(body):
	if body.name=="Steve":
		player = body
		chase = true
#
func _on_player_area_body_entered(body):	
	if body.name == "Steve":
		body.ouch(position.x)
		chase = false
		global_position.y = -10


func _on_top_area_body_entered(body):
	if body.name == "Steve":
		die()
