extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var val = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (val == 0):
		$Popup/Label.text = "miss"
	else:
		val = round_to_half(val)
		$Popup/Label.text = str(val)
	$Popup/AnimationPlayer.play("PopRight")

func round_to_half(to_round: float) -> float:
	to_round *= 2;
	to_round = int(to_round)
	to_round = float(to_round) / 2
	return to_round

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pop():
	self.queue_free()
