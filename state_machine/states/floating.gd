extends PlayerState

var collision_mask := 0
var collision_layer := 0

func enter(previous_state_path: String, data := {}) -> void:
	player.reparent(player.carried_rb)
	player.position = Vector2.ZERO

	
func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		player.reparent(get_tree().current_scene.get_node("Level"))
		player.carried_rb = null
		finished.emit(FALLING)
	
		await get_tree().create_timer(0.2).timeout
		player_enable_collision()
	
func player_enable_collision() -> void:
	player.enable_collision()
