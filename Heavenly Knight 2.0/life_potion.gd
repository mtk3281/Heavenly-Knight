extends Node2D


func _on_area_2d_body_entered(body):
	if body.name=="Steve":
		if GlobalVar.life_count <=4:
			GlobalVar.life_count += 1
		queue_free()
