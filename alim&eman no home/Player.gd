extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200

var JUMP_HEIGHT = 0
var motion = Vector2()
var time = 0.01

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = true
		$Sprite.play("running")
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = false
		$Sprite.play("running")
	
	else:
		motion.x = 0
		$Sprite.play("idle")
		
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			JUMP_HEIGHT += -150
			time += 0.1
			
			if JUMP_HEIGHT <-850:
				JUMP_HEIGHT = -849
	
	if not is_on_floor():
		time = 0
	
	motion.y += GRAVITY
	
	if Input.is_action_just_released("ui_up"):
		motion.y = JUMP_HEIGHT
	
		time = 0
		yield(get_tree().create_timer(time),"timeout")
		JUMP_HEIGHT = 0
	
	motion = move_and_slide(motion, UP)
	pass


func _on_SwordHit_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage
