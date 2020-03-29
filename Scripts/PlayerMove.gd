extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 30

const attack_time = 0.9

var attack_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	attack_timer = attack_time

func attack(velocity):
	if attack_timer < attack_time:
		return
	attack_timer = 0
	if velocity.x == 1:
		$AnimationPlayer.play("AttackRight")
	elif velocity.x == -1:
		$AnimationPlayer.play("AttackLeft")
	elif velocity.y == 1:
		$AnimationPlayer.play("AttackDown")
	elif velocity.y == -1:
		$AnimationPlayer.play("AttackUp")
	else:
		$AnimationPlayer.play("AttackDown")
	

func set_animation(name):
	if attack_timer >= attack_time:
		$AnimationPlayer.play(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	
	attack_timer += delta
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		set_animation("WalkLeft")
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		set_animation("WalkRight");
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		set_animation("WalkUp");
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		set_animation("WalkDown");
	if Input.is_action_just_pressed("attack"):
		attack(velocity)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		set_animation("Idle");
	position += velocity * delta
	
