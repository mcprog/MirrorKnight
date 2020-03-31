extends Area2D

const jump_distance = 13
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum State {
	Idle, Roll, Jump, Spit, Die
}

enum ColorType {
	Green, Blue, Red, Yellow
}

var state
var next_state

const EnergyHurt = 2
const EnergyDe = 0
const EnergyNormal = 1
var energy_target = EnergyNormal


export(ColorType) var color

export var health = 5
export(float) var energy_speed = 1.25

# Called when the node enters the scene tree for the first time.
func _ready():
	state = State.Idle
	set_animation(state, color)

func set_animation(state, color_type):
	$AnimationPlayer.play(ColorType.keys()[color_type] + State.keys()[state])

func set_attacked():
	next_state = State.Roll

# for when the enemy is dead
func pop():
	get_tree().queue_delete(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == State.Idle:
		# set idle animation and reset attacks
		pass
	elif state == State.Roll:
		# set rool animation, pause movement, do damage
		pass
	elif state == State.Jump:
		# set jump animation, choose jump location, jump
		pass
	elif state == State.Spit:
		# set spit animation, invuln to attacks,
		pass
	else:
		# run death animation, then pop
		pop()
	
	# energy logic
	if energy_target == EnergyNormal and $Light2D.energy < EnergyNormal:
		$Light2D.energy += delta * energy_speed
	elif energy_target == EnergyHurt and $Light2D.energy < EnergyHurt:
		$Light2D.energy += delta * energy_speed
	elif energy_target == EnergyDe and $Light2D.energy > EnergyDe:
		$Light2D.energy -= delta * energy_speed
	 


func _on_Slime_body_entered(body):
	energy_target = EnergyDe


func _on_Slime_body_exited(body):
	energy_target = EnergyNormal
