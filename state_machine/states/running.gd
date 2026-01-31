extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("run")
	
func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left" + player.action_suffix, "move_right" + player.action_suffix) * player.WALK_SPEED
	player.velocity.x = move_toward(player.velocity.x, direction, player.ACCELERATION_SPEED * delta)
	player.velocity.y = minf(player.TERMINAL_VELOCITY, player.velocity.y + player.gravity * delta)
	player.move_and_slide()
	
	if not is_zero_approx(player.velocity.x):
		if player.velocity.x > 0.0:
			player.sprite.scale.x = 1.0
		else:
			player.sprite.scale.x = -1.0
			
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif is_equal_approx(direction, 0.0):
		finished.emit(IDLE)
