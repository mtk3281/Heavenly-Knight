extends Control

var scene

func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.name != "Exit":
		#button.pressed.connect(_on_button_pressed.bind(button.scene_to_load))
			button.pressed.connect(_on_button_pressed.bind(button.scene_to_load))

func _on_button_pressed(scene_to_load):
	scene = scene_to_load
	print("Fade")
	print(scene_to_load)
	$FadeIn.visible = true
	$FadeIn.fade_in()


func _on_exit_pressed():
	get_tree().quit()


func _on_fade_in_fade_finished():
	get_tree().change_scene_to_file(scene)
