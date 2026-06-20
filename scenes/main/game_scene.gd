extends Node2D

signal leveled_up


func _ready() -> void:
	var enemy_array: Array = get_tree().get_nodes_in_group("Enemies")
	for i: Enemy in enemy_array:
		i.died.connect(experience_gained)
	var player: Player = get_tree().get_first_node_in_group("Player")
	leveled_up.connect(player.calculate_stats)


func experience_gained(exp_gain: int) -> void:
	if PlayerData.level == LevelData.MAX_LEVEL:
		return
	var new_experience: int = PlayerData.experience + exp_gain
	if new_experience >= LevelData.LEVEL_THRESHOLDS[PlayerData.level - 1]:
		level_up(new_experience)
	else:
		PlayerData.experience = new_experience


func level_up(new_experience: int) -> void:
	print("leveled up")
	new_experience -= LevelData.LEVEL_THRESHOLDS[PlayerData.level - 1]
	PlayerData.level += 1
	PlayerData.experience = new_experience
	leveled_up.emit()
