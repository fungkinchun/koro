extends PlayerState


func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left" + player.action_suffix, "move_right" + player.action_suffix) * player.WALK_SPEED
	player.velocity.x = move_toward(player.velocity.x, direction, player.ACCELERATION_SPEED * delta)
	player.velocity.y = minf(player.TERMINAL_VELOCITY, player.velocity.y + player.gravity * delta)
	player.move_and_slide()
	
	if player.carried_rb:
		finished.emit(FLOATING)

	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
