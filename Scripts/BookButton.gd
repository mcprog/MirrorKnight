extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var perform_click = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func clicked_down():
	$AnimationPlayer.play("ClickUp")

func clicked_up():
	perform_click = true


func _on_BookButton_mouse_entered():
	$AnimationPlayer.play("Wiggle")


func _on_BookButton_pressed():
	$AnimationPlayer.play("ClickDown")
