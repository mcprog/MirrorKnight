extends KinematicBody2D

const Attacks = preload("res://Scripts/Attacks.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 45
export(int) var health = 20
export(float) var dmg_done = 3
export(float) var crit_chance = .23

const attack_time = 0.9

var attack_timer
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	attack_timer = attack_time

func attack(velocity):
	if attack_timer < attack_time:
		return
	attack_timer = 0
	if velocity.x > 0:
		$AnimationPlayer.play("AttackRight")
	elif velocity.x < 0:
		$AnimationPlayer.play("AttackLeft")
	elif velocity.y == 1:
		$AnimationPlayer.play("AttackDown")
	elif velocity.y == -1:
		$AnimationPlayer.play("AttackUp")
	else:
		$AnimationPlayer.play("AttackDown")

func attack_done():
	var enemies = $Area2D.get_overlapping_bodies();
	print("count:" + str(enemies.size()))
	for enemy in enemies:
		var severity = Attacks.get_severity(crit_chance)
		print("severity found= " + str(severity))
		enemy.handle_attack(dmg_done, Attacks.AttackType.Normal, severity)

func handle_attack():
	print("ow")

func set_animation(name):
	if attack_timer >= attack_time:
		$AnimationPlayer.play(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2()
	
	attack_timer += delta
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		set_animation("WalkLeft")
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		set_animation("WalkRight");
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		if velocity.x == 0:
			set_animation("WalkUp");
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		if velocity.x == 0:
			set_animation("WalkDown");
	if Input.is_action_just_pressed("attack"):
		attack(velocity)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		set_animation("Idle");
	#position += velocity * delta

func _physics_process(delta):
	move_and_slide(velocity);
	
