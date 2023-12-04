extends Control


func _on_go_back_2_pressed():
	GlobalVar.reset()
	GlobalVar.level=1
	get_tree().change_scene_to_file("res://title_menu.tscn")
