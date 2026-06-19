class_name Player
extends CharacterBody2D

@export_category("Stats")
@export var speed: int = 400
@export var attack_speed: float = 0.6
@export var attack_damage: int = 60
@export var hitpoints: int = 150

var move_direction: Vector2 = Vector2.ZERO
var last_facing_direction: Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	animation_tree.set_active(true)


func _process(_delta: float) -> void:
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")


func take_damage(damage_taken: int) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0:
		death()


func death() -> void:
	state_machine.force_change_state("die")
