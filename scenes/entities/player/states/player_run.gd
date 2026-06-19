class_name PlayerRun
extends PlayerState


func enter() -> void:
	player.animation_playback.travel("run")


func update(_delta: float) -> void:
	if player.move_direction == Vector2.ZERO:
		transitioned.emit(self, "idle")


func physics_update(_delta: float) -> void:
	player.set_velocity(player.move_direction.normalized() * player.speed)
	
	if player.velocity:
		player.last_facing_direction = player.move_direction
	
		if player.last_facing_direction.x != 0:
			player.sprite_2d.flip_h = player.last_facing_direction.x < 0
	
	player.move_and_slide()


func handle_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		transitioned.emit(self, "attack")
