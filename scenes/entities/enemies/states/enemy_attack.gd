class_name EnemyAttack
extends EnemyState


func enter() -> void:
	attack()


func attack() -> void:
	var player_pos: Vector2 = enemy.player.global_position
	var attack_dir: Vector2 = (player_pos - enemy.global_position).normalized()
	enemy.sprite_2d.flip_h = attack_dir.x < 0 and abs(attack_dir.x) >= abs(attack_dir.y)
	enemy.animation_tree.set("parameters/attack/BlendSpace2D/blend_position", 
			attack_dir)
	enemy.animation_playback.travel("attack")
	
	await get_tree().create_timer(enemy.attack_speed).timeout
	transitioned.emit(self, "idle")


func _on_hit_box_area_entered(area: Area2D) -> void:
	var player: Player = area.owner
	player.take_damage(player.attack_damage)
