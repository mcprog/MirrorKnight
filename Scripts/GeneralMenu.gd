extends CanvasLayer


var in_transition = false
var showing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func show():
	in_transition = true
	$AnimationPlayer.play("Show")
	showing = true

func hide():
	in_transition = true
	$AnimationPlayer.play("Hide")
	showing = false

func _process(delta):
	if not in_transition and Input.is_action_just_pressed("ui_home"):
		if showing:
			hide()
		else:
			show()

func _on_AnimationPlayer_animation_finished(anim_name):
	in_transition = false
