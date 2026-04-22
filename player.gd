extends CharacterBody3D
var speed : float = 5.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.y * speed
	move_and_slide()
