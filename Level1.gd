extends Node2D

var interact_value = "" # 0 means in no gate
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if interact_value == "Gate1":
			$Player.position.x = 3635
			$Player.position.y = 1878
		if interact_value == "Gate2":
			$Player.position.x = 3321
			$Player.position.y = 776
			
func _on_Gate1_body_entered(body):
	interact_value = "Gate1"
	
func _on_Gate2_body_entered(body):
	interact_value = "Gate2"
