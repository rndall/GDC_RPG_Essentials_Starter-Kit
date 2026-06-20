class_name Enemy
extends CharacterBody2D

@warning_ignore("unused_signal")
signal died(xp_amount: int)

@export_category("Stats")
@export var speed: int = 128
@export var attack_damage: int = 10
@export var attack_speed: float = 1.0
@export var hitpoints: int = 180
@export var aggro_range: float = 256.0
@export var attack_range: float = 80.0
@export var xp_value: int = 500

@export_category("Related Scenes")
@export var death_packed: PackedScene

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var spawn_point: Vector2 = global_position
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var state_machine: StateMachine = $StateMachine
@onready var effects_scene = %Effects


func _ready() -> void:
	animation_tree.set_active(true)


func take_damage(damage_taken: int) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0:
		death()


func death() -> void:
	state_machine.force_change_state("die")


func get_distance_to_player() -> float:
	return global_position.distance_to(player.global_position)


func move(target_position: Vector2) -> void:
	navigation_agent_2d.target_position = target_position
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	velocity = global_position.direction_to(next_path_position) * speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(velocity)
	
	move_and_slide()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	navigation_agent_2d.velocity = safe_velocity


func flip_sprite_h() -> void:
	if velocity.x < -0.01:
		sprite_2d.flip_h = true
	elif velocity.x > 0.01:
		sprite_2d.flip_h = false
