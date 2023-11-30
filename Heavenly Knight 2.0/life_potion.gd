extends Node2D


func _on_area_2d_body_entered(body):
	if body.name=="Steve":
		if GlobalVar.life_count <=4:
			GlobalVar.life_count += 1
#		print(get_parent().get_node("Player"))
#		await get_tree().create_timer(0.2).timeout
		queue_free()
