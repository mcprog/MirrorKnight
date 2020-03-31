extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var showing
var in_transistion

# Called when the node enters the scene tree for the first time.
func _ready():
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_home") and not in_transistion:
		if showing:
			hide();
		else:
			show()


func show():
	in_transistion = true
	$AnimationPlayer.play("Show")
	showing = true
	
func hide():
	in_transistion = true
	$AnimationPlayer.play("Hide")
	showing = false

func done_transition():
	in_transistion = false;

func _on_Close_pressed():
	hide()
