class_name Enemy
extends CharacterBody2D

@export_category("Stats")
@export var hitpoints: int = 180
@onready var state_machine: StateMachine = $StateMachine

@export_category("Related Scenes")
@export var death_packed: PackedScene

@onready var effects_scene = %Effects


func take_damage(damage_taken: int) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0:
		death()


func death() -> void:
	state_machine.force_change_state("die")
