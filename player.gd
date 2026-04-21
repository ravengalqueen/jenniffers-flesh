extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

func _ready() -> void:
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta: float) -> void:
	
	var input := Vector3.ZERO
	input.x = Input.get_axis("left_movement", "right_movement")
	input.z = Input.get_axis("forward_movement", "backward_movement")
	apply_central_force(basis * input * 1200.00 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#rotate_y(twist_input) uncommenting will result on mobility loss
	
	$Camera3D.rotate_x(pitch_input)
	$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -1.5, 1.5)
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			
