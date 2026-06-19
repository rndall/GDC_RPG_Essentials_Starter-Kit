class_name EnemyIdle
extends EnemyState


func physics_update(_delta: float) -> void:
	if enemy.get_distance_to_player() <= enemy.attack_range:
		transitioned.emit(self, "attack")
