class_name EnemyDie
extends EnemyState


func enter() -> void:
	enemy.queue_free()
