class_name Bullet extends RigidBody2D


@onready var animation_player := $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.2).timeout
	$CollisionShape2D.disabled = false
	lock_rotation = true
	
func destroy() -> void:
	animation_player.play(&"destroy")

func _on_body_entered(body: Node) -> void:
	if body is Player:
		(body as Player).carried_rb = self
		(body as Player).disable_collision()
	if body is Enemy:
		(body as Enemy).destroy()

func _on_body_exited(body: Node) -> void:
	return
	if body is Player:
		(body as Player).enable_collision()
		
