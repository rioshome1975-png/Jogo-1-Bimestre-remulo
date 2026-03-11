extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 80.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor():

		if direction > 0:
			anim.flip_h = false
			anim.play("Walk")
		elif direction < 0:
			anim.flip_h = true
			anim.play("Walk")
		else:
			anim.play("idle")
	else:
		anim.play("jump")


	move_and_slide()
	
func take_damage():
	Global.health -= 1
	
	if Global.health <= 0:
		die()

func die():
	print("Game Over")
	Global.health = 1 # Reseta vida
	Global.coins = 0 # Reseta moedas
	get_tree().reload_current_scene()
	

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.take_damage()


@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
