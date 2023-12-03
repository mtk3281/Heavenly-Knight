extends CanvasLayer
var style = {"g":load("res://lifebar styles/green.tres"),"b":load("res://lifebar styles/blue.tres"),"r":load("res://lifebar styles/red.tres"),"f":load("res://lifebar styles/flick.tres"),"p":load("res://lifebar styles/flickColor.tres")}
var color = {"g":Color('00a83a'),"b":Color("248dff"),"r":Color("ff454b")}

var f = false
@onready var tween = get_tree().create_tween()

@onready var health = $Health/ProgressBar


func _ready():

	GlobalVar.connect("lifecount_changed", Callable(self, "_on_lifecount_changed"))
	tween.tween_property(health,"value",GlobalVar.life_count*25,2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	
func _physics_process(_delta):

	$fps.text = "FPS "+ str(Engine.get_frames_per_second())
	
	$Coin/ProgressBar.set_value_no_signal(GlobalVar.coin)
	$Coin/ProgressBar.max_value = GlobalVar.total_coin
	
	$Enemy/ProgressBar.max_value = GlobalVar.total_enemy
	
	$Enemy/ProgressBar.set_value_no_signal(GlobalVar.enemy_dead_count)
	
	if GlobalVar.life_count != 1:
		f=false
	if GlobalVar.life_count==4:
		$Health/ProgressBar.add_theme_stylebox_override("fill", style["g"])
		$Label2.add_theme_color_override("font_color",Color('00a83a'))
	elif GlobalVar.life_count==3:
		$Health/ProgressBar.add_theme_stylebox_override("fill", style["b"])
		$Label2.add_theme_color_override("font_color",Color("248dff"))
	elif GlobalVar.life_count==2:
		$Health/ProgressBar.add_theme_stylebox_override("fill", style["r"])
		$Label2.add_theme_color_override("font_color",Color("ff454b"))
	elif GlobalVar.life_count==1:
		$Health/ProgressBar.add_theme_stylebox_override("fill", style["p"])
		f = true


func _on_timer_timeout():
	if f:
		$Health/ProgressBar.add_theme_stylebox_override("fill", style["f"])

func _on_lifecount_changed(new_lifecount):
	var tween1 = get_tree().create_tween()
	tween1.tween_property(health,"value",new_lifecount*25,1).set_trans(Tween.TRANS_LINEAR)
