class_name EnemyDie
extends EnemyState


func enter() -> void:
	var death_scene: Node2D = enemy.death_packed.instantiate()
	death_scene.position = enemy.global_position + Vector2(0, -32)
	enemy.effects_scene.add_child(death_scene)
	enemy.queue_free()
