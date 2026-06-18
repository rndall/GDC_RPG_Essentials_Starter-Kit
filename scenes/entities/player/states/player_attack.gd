class_name PlayerAttack
extends PlayerState


func enter() -> void:
	player.animation_playback.travel("attack")
	attack()


func attack() -> void:
	var mouse_pos: Vector2 = player.get_global_mouse_position()
	var attack_dir: Vector2 = (mouse_pos - player.global_position).normalized()
	player.sprite_2d.flip_h = attack_dir.x < 0 and abs(attack_dir.x) >= abs(attack_dir.y)
	player.animation_tree.set("parameters/attack/BlendSpace2D/blend_position", 
			attack_dir)
	
	await get_tree().create_timer(player.attack_speed).timeout
	transitioned.emit(self, "idle")
