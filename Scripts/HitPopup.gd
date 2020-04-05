extends Node2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var val = 0

enum Animations {
	PopRight, PopRightRed, PopLeft, PopLeftRed
}

export(Animations) var animation

# Called when the node enters the scene tree for the first time.
func _ready():
	if (val < 0):
		animation = Animations.PopRightRed
	else:
		animation = Animations.PopRight
	
	if (val == 0):
		$Popup/Label.text = "miss"
	else:
		val = round_to_half(val)
		$Popup/Label.text = str(val)
	$Popup/AnimationPlayer.play(Animations.keys()[animation])
	
func set_position(position_to):
	position = position_to

func round_to_half(to_round: float) -> float:
	to_round *= 2;
	to_round = int(to_round)
	to_round = float(to_round) / 2
	return to_round

static func init(instance, val, position_to):
	instance.val = val;
	instance.position = position_to;

func pop():
	self.queue_free()
