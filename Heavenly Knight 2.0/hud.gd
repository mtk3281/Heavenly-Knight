extends CanvasLayer


func _ready():
	$Panel/count.text = str(0)

func _physics_process(_delta):
	$Panel/count.text = str(GlobalVar.coin)
	$Control/ProgressBar.set_value_no_signal(GlobalVar.life_count)
