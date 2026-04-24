extends Camera3D

@export var dead_zone: float = 1.0
@export var min_x: float = -6.5
@export var max_x: float = 21
var player: Node3D

func _ready():
	self.make_current()


func _process(delta: float) -> void:

	
	if not player:
		player = get_tree().get_first_node_in_group("player")
		print("looking for player: ", player)
		return
	print("following player at: ", player.global_position.x)
	var diff = player.global_position.x - global_position.x
	if abs(diff) > dead_zone:
		var new_x = clamp(player.global_position.x, min_x, max_x)
		global_position.x = lerp(global_position.x, new_x, delta * 5.0)
