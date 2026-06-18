extends CharacterBody2D

enum State {
	IDLE, 
	RUN, 
	ATTACK, 
	DEAD
}

@export_category("Stats")
@export var speed: int = 400

var state: State = State.IDLE
var move_direction: Vector2 = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]


func _physics_process(_delta: float) -> void:
	movement_loop()


func movement_loop() -> void:
	move_direction = Input.get_vector("move_left", 
			"move_right", 
			"move_up", 
			"move_down")
	
	var motion: Vector2 = move_direction.normalized() * speed
	set_velocity(motion)
	
	move_and_slide()
	
	if state == State.IDLE or State.RUN:
		if move_direction.x < -0.01:
			$Sprite2D.flip_h = true
		elif move_direction.x > 0.01:
			$Sprite2D.flip_h = false
	
	if motion != Vector2.ZERO and state == State.IDLE:
		state = State.RUN
		update_animaion()
	elif motion == Vector2.ZERO and state == State.RUN:
		state = State.IDLE
		update_animaion()


func update_animaion() -> void:
	match state:
		State.IDLE:
			animation_playback.travel("idle")
		State.RUN:
			animation_playback.travel("run")
		State.ATTACK:
			animation_playback.travel("attack")
