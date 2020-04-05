extends KinematicBody2D

const Attacks = preload("res://Scripts/Attacks.gd")
const HitPopup = preload("res://Scenes/HitPopup.tscn")
const HitPopupClass = preload("res://Scripts/HitPopup.gd")

const jump_distance = 13
const scan_speed = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum State {
	Idle, Roll, Jump, Charge, Spit, Die
}

enum ColorType {
	Yellow, Red, Green, Blue
}

var prev_state
var state
var next_state

const EnergyHurt = 2
const EnergyDe = 0
const EnergyNormal = 1
const EnergyLowPulse = 0.65
const EnergyPulseFactor = 0.45
var energy_target = EnergyNormal


export(ColorType) var color
export(float) var speed = 30

export var health = 5
export var attack_strength = 1
export(float) var energy_speed = 1.25
export(float) var energy_hurt_speed = 2.5

var pulse_speed_factor = 1

var armor = Attacks.NoArmor

var victim;

var velocity = Vector2();

# Called when the node enters the scene tree for the first time.
func _ready():
	state = State.Idle
	set_animation(state, color)

func set_animation(state, color_type):
	$AnimationPlayer.play(ColorType.keys()[color_type] + State.keys()[state])

func handle_attack(damage, type, severity):
	next_state = State.Roll
	var dmg = Attacks.effective_damage(damage, type, severity, armor)
	var instance = HitPopup.instance()
	HitPopupClass.init(instance, dmg, position)
	get_parent().get_child(0).add_child(instance)
	health -= dmg;
	if (health <= 0):
		next_state = State.Die
	else:
		energy_target = EnergyHurt

# imma make you pop like that
# for when the enemy is dead
func pop():
	get_tree().queue_delete(self)

func attack():
	if victim == null:
		return;
	victim.handle_attack(attack_strength, color)

# returns true if neither ray sees the player
func check_rays(delta) -> bool:
	if $RayCast2D.is_colliding():
		velocity = Vector2.DOWN.rotated($RayCast2D.rotation)
		$RayCast2D2.rotation = $RayCast2D.rotation
	elif $RayCast2D2.is_colliding():
		velocity = Vector2.DOWN.rotated($RayCast2D2.rotation)
		$RayCast2D.rotation = $RayCast2D2.rotation
	else:
		$RayCast2D.rotation_degrees += scan_speed * delta
		$RayCast2D2.rotation_degrees -= scan_speed * delta
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2();
	if next_state != null:
		prev_state = state
		state = next_state
		next_state = null
		set_animation(state, color)
	
	if state == State.Idle:
		if not check_rays(delta):
			next_state = State.Jump
	elif state == State.Roll:
		# set rool animation, pause movement, do damage
		pass
	elif state == State.Jump:
		if check_rays(delta):
			next_state = State.Idle
	elif state == State.Spit:
		# set spit animation, invuln to attacks,
		pass
	else:
		# run death animation, then pop
		pass
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if velocity.x > 0:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
	
	
	update_lighting(delta)

# energy logic
func update_lighting(delta):
	if energy_target == EnergyNormal:
		if $Light2D.energy < EnergyNormal:
			$Light2D.energy += delta * energy_speed * pulse_speed_factor
		else:
			energy_target = EnergyLowPulse
			pulse_speed_factor = EnergyPulseFactor
	elif energy_target == EnergyHurt and $Light2D.energy < EnergyHurt:
		$Light2D.energy += delta * energy_hurt_speed
	elif energy_target == EnergyDe and $Light2D.energy > EnergyDe:
		$Light2D.energy -= delta * energy_speed
	elif energy_target == EnergyLowPulse:
		if $Light2D.energy > EnergyLowPulse:
			$Light2D.energy -= delta * energy_speed * pulse_speed_factor
		else:
			energy_target = EnergyNormal

func charge_up():
	next_state = State.Charge

func on_charged():
	next_state = State.Spit

func revert_state():
	next_state = State.Idle
	if (victim != null):
		next_state = State.Charge
	 
func _physics_process(delta):
	move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	energy_target = EnergyDe
	pulse_speed_factor = 1;
	
	victim = body
	charge_up()


func _on_Area2D_body_exited(body):
	energy_target = EnergyNormal
	victim = null
