extends KinematicBody2D

const GRAVITY = 10
const SPEED = 100
const UP = Vector2(0, -1)

var motion = Vector2()
var direction = 1
var is_dead = false
var Health = 3

func _ready():
	pass 

func dead():
	is_dead = true
	motion = Vector2()
	$AnimatedSprite.play("dead")

func _physics_process(delta):
	if Health <= 0:
		queue_free()
		
	if is_dead == false:
		motion.x = SPEED * direction
		
		if direction == 1:
			$Sprite.flip_h = true
		
		else:
			$Sprite.flip_h = false
		$Sprite.play("walk")
		motion.y += GRAVITY
		
		motion = move_and_slide(motion, UP)
	
	if is_on_wall():
		direction = direction * -1
