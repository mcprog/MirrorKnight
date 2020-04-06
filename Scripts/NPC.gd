extends Area2D



export(String) var dialog_name

var player;

func _ready():
	$Dialog.dialog_key = dialog_name
	$Dialog.portrait = $Portait.texture
	$Dialog.load_dialogs()


func _process(delta):
	if Input.is_action_just_pressed("interact") and player != null:
		print("interact pressed");
		$Dialog/Control.visible = true;





func _on_NPC_body_entered(body):
	player = body;



func _on_NPC_body_exited(body):
	player = null
	$Dialog/Control.visible = false;
