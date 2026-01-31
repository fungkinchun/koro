extends PlayerState

func physics_update(delta: float) -> void:
	player.gun.shoot(
		-(player.position - player.get_global_mouse_position()).normalized())
	finished.emit(IDLE)
