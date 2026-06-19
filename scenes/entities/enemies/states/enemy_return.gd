class_name EnemyReturn
extends EnemyState

func enter() -> void:
	enemy.animation_playback.travel("run")

func physics_update(_delta: float) -> void:
	enemy.flip_sprite_h()
	enemy.move(enemy.spawn_point)
	
	#if enemy.global_position.distance_to(enemy.spawn_point) > 5:
		#enemy.global_position = enemy.spawn_point
		#transitioned.emit(self, "idle")
