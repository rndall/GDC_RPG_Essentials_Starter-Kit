class_name PlayerDie
extends PlayerState

func enter() -> void:
	player.game_over.emit(false)
