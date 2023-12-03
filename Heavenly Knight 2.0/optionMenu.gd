extends Control

var scene

func _on_go_back_pressed():
	scene = "res://title_menu.tscn"
	$FadeIn.visible=true
	$FadeIn/AnimationPlayer.play("Fade_In")



func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	#goback main menu
	if anim_name == "Fade_In":
		get_tree().change_scene_to_file(scene)
	#How to play		
	elif anim_name == "Fade_In_2":
		$FadeIn.visible = false
		get_tree().change_scene_to_file("res://how_to_play.tscn")
	#Controls	
	elif anim_name == "Fade_In_3":
		$FadeIn.visible = false
		get_tree().change_scene_to_file("res://Controls.tscn")


func _on_how_to_play_pressed():
	$FadeIn.visible=true
	$FadeIn/AnimationPlayer.play("Fade_In_2")


func _on_controls_pressed():
	$FadeIn.visible=true
	$FadeIn/AnimationPlayer.play("Fade_In_3")
