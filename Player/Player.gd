extends KinematicBody2D

const GRAVITY = 30
const WALKING_SPEED = 200
const CROUCHING_SPEED = 100



var velocity = Vector2.ZERO
var crouching_starts = false
var crouching_ends = false
export var crouching = false
export var direction = 0 # 1 => right, -1 => left, 0 => stop

func _ready(): # TODO: set initial pos 
	pass
	
func _physics_process(delta):
	input_checker() # checking for inputs
	moving() # moves objects due to inputs
	animating() # animations of objects
		
	direction = 0 # will stop if nothing were submited 
	
	

func input_checker():
	if Input.is_action_pressed("move_right"):
		direction = 1
		$BodyParts/NormalFaceR.visible = true
		$BodyParts/NormalFaceL.visible = false
	if Input.is_action_pressed("move_left"):
		direction = -1 
		$BodyParts/NormalFaceL.visible = true
		$BodyParts/NormalFaceR.visible = false
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_left"):
		direction = 0
	if Input.is_action_just_pressed("crouch"):
		crouching_starts = true
	if Input.is_action_pressed("crouch"):
		crouching = true
	else:
		crouching = false
	if Input.is_action_just_released("crouch"):
		crouching_ends = true

func moving():
	if not is_on_floor():
		velocity.y += GRAVITY # gravity
	if crouching:
		velocity.x = direction * CROUCHING_SPEED
	else:
		velocity.x = direction * WALKING_SPEED
	# moving
	velocity = move_and_slide(velocity, Vector2.UP)
	# decrease in velocity if not moving
	velocity.x = lerp(velocity.x, 0, 0.1)
		
func stop():
	if abs(velocity.x) <= 3 and $AnimationPlayer.current_animation_position <= 0.05:
		$AnimationPlayer.stop()

func animating():
	# Face direction
	if direction == 1:
		$BodyParts/NormalFaceR.visible = true
		$BodyParts/NormalFaceL.visible = false
	elif direction == -1:
		$BodyParts/NormalFaceL.visible = true
		$BodyParts/NormalFaceR.visible = false
	# changing pos animations
	if crouching_starts:
		$AnimationPlayer.play("WalkToCrouch")
		crouching_starts = false
	if crouching_ends:
		$AnimationPlayer.play_backwards("WalkToCrouch")
		crouching_ends = false
	if crouching and abs(direction) == 1 and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Crouch")
	elif abs(direction) == 1 and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Walk")
	# stoping animation if not moving
	elif ($AnimationPlayer.is_playing() and abs(velocity.x) <= 3 and $AnimationPlayer.current_animation_position <= 0.05) and ($AnimationPlayer.current_animation == "Walk" or $AnimationPlayer.current_animation == "Crouch"): 
		$AnimationPlayer.stop()
	
		
