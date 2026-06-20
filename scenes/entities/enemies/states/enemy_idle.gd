class_name EnemyIdle
extends EnemyState


func enter() -> void:
	enemy.animation_playback.travel("idle")


func physics_update(_delta: float) -> void:
	enemy.flip_sprite_h()
	
	if enemy.get_distance_to_player() <= enemy.attack_range:
		transitioned.emit(self, "attack")
	elif enemy.get_distance_to_player() <= enemy.aggro_range:
		transitioned.emit(self, "chase")
	elif enemy.global_position.distance_to(enemy.spawn_point) > 32:
		transitioned.emit(self, "return")
