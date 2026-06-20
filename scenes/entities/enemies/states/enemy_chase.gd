class_name EnemyChase
extends EnemyState


func enter() -> void:
	enemy.animation_playback.travel("run")


func physics_update(_delta: float) -> void:
	enemy.flip_sprite_h()
	enemy.move(enemy.player.global_position)
	
	if enemy.get_distance_to_player() <= enemy.attack_range:
		transitioned.emit(self, "attack")
	elif enemy.get_distance_to_player() > enemy.aggro_range and enemy.global_position.distance_to(enemy.spawn_point) > 32:
		transitioned.emit(self, "return")
