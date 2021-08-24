extends KinematicBody2D

const GRAVITY = 30
const SPEED = 100


var velocity = Vector2.ZERO

func _ready():
	pass 
	
func _physics_process(delta):
	input_checcker()
	
	# moving
	move_and_slide(velocity, Vector2.UP)
	# resets animation if not moving 
	if $AnimationPlayer.is_playing():
		stop()
	
	# will decrease in x velocit if A/D are not pressed
	velocity.x = lerp(velocity.x, 0, 0.1)

func input_checcker():
	if Input.is_action_pressed("move_right"):
		walk(1)
		$BodyParts/NormalFaceR.visible = true
		$BodyParts/NormalFaceL.visible = false
	if Input.is_action_pressed("move_left"):
		walk(-1)
		$BodyParts/NormalFaceL.visible = true
		$BodyParts/NormalFaceR.visible = false

func walk(direction):
	velocity.x = direction * SPEED
	if not is_on_floor():
		$AnimationPlayer.play("Walk")
		
func stop():
	if abs(velocity.x) <= 3 and $AnimationPlayer.current_animation_position <= 0.05:
		$AnimationPlayer.stop()

