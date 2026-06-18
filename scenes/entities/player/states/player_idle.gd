class_name PlayerIdle
extends PlayerState


func enter() -> void:
	player.animation_playback.travel("idle")


func update(_delta: float) -> void:
	if player.move_direction != Vector2.ZERO:
		transitioned.emit(self, "run")


func handle_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		transitioned.emit(self, "attack")
