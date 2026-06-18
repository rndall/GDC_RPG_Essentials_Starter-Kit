extends CharacterBody2D

@export_category("Stats")
@export var speed: int = 400

var move_direction: Vector2 = Vector2.ZERO


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
