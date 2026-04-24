extends Area3D

@export var target_door_id := ""
@export var is_locked := true
var player_is_inside := false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		Hud.show_hint()
		player_is_inside = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		Hud.hide_hint()
		player_is_inside = false
		
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("interact") and player_is_inside:
		if is_locked:
			Hud.display_message("It appears this door is locked")
		else:
			print("travelling to: ", target_door_id)
			RoomManager.travel_to(target_door_id)
