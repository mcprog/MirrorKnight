extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		print(str(get_local_mouse_position()))
		$X.position = get_local_mouse_position()
		$RayCast2D.look_at(get_global_mouse_position())
		
	$Sprite.rotation = lerp_angle($Sprite.rotation, $RayCast2D.rotation, delta * speed)
