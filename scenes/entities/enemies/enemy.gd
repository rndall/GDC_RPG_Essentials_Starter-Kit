class_name Enemy
extends CharacterBody2D

@export_category("Stats")
@export var speed: int = 128
@export var attack_damage: int = 10
@export var attack_speed: float = 1.0
@export var hitpoints: int = 180
@export var aggro_range: float = 256.0
@export var attack_range: float = 80.0
@onready var state_machine: StateMachine = $StateMachine

@export_category("Related Scenes")
@export var death_packed: PackedScene

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var spawn_point: Vector2 = global_position
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var player: Player = get_tree().get_first_node_in_group("Player")
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
