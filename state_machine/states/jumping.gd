extends PlayerState

func can_enter(previous_state_path: String, data := {}) -> bool:
	return player.is_on_floor() || player._double_jump_charged

func enter(previous_state_path: String, data := {}) -> void:
	if player.is_on_floor():
		player.jump_sound.pitch_scale = 1.0
	elif player._double_jump_charged:
		player._double_jump_charged = false
		player.velocity.x *= 2.5
		player.jump_sound.pitch_scale = 1.5

	player.velocity.y = player.JUMP_VELOCITY
	player.jump_sound.play()



func physics_update(delta: float) -> void:
	var input_dir := Input.get_axis(
		"move_left" + player.action_suffix,
		"move_right" + player.action_suffix
	)
	
	var target_speed := input_dir * player.WALK_SPEED
	var accel := player.ACCELERATION_SPEED if abs(input_dir) > 0 else player.ACCELERATION_SPEED
	
	player.velocity.x = move_toward(
		player.velocity.x,
		target_speed,
		accel * delta
	)
	
	if not is_zero_approx(player.velocity.x):
		player.sprite.scale.x = sign(player.velocity.x)
	
	player.velocity.y += player.gravity * delta
	player.velocity.y = min(player.velocity.y, player.TERMINAL_VELOCITY)
	
	if Input.is_action_just_released("jump" + player.action_suffix) and player.velocity.y < 0:
		player.velocity.y *= 0.5
	
	player.move_and_slide()
	
	if player.is_on_floor():
		if abs(player.velocity.x) > 10:
			finished.emit("Running")
		else:
			finished.emit("Idle")
	elif player.velocity.y >= 0:
		finished.emit("Falling")
