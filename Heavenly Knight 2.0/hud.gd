extends CanvasLayer


func _ready():
	$count.text = str(0)

func _physics_process(_delta):
	$count.text = str(GlobalVar.coin)
	
