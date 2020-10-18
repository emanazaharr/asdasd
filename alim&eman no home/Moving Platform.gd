extends KinematicBody2D

const SPEED = 110
const UP = Vector2(0, -1)

var motion = Vector2()
var direction = 1

func _ready():
	pass 

func _physics_process(delta):
	motion.x = SPEED * direction
	
	if direction == 1:
		$Sprite.flip_h = true
	
	else:
		$Sprite.flip_h = false
	
	motion = move_and_slide(motion, UP)
	
	if is_on_wall():
		direction = direction * -1
