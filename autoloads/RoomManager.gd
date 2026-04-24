extends Node

var player_scene: PackedScene 
var start_room: PackedScene
var room_pool: Array[PackedScene] = []

var player: Node = null
var shuffled_rooms: Array[PackedScene] = []
var current_index: int = 0
var current_room: Node = null
var is_transitioning: bool = false

func _ready():
	start_room = preload("res://rooms/Test_Room.tscn")
	room_pool = [
		preload("res://rooms/Test_Room.tscn"),
		preload("res://rooms/Test_Room_2.tscn")
	]
	shuffled_rooms = room_pool.duplicate()
	shuffled_rooms.shuffle()
	var player_scene = preload("res://player.tscn")
	player = player_scene.instantiate()
	print("spawning player, existing player: ", player)
	add_child(player)
	player.global_position = Vector3(0, 2, 0)
	_load_room_scene(start_room, "test_room_one_left")

func travel_to(target_door_id: String):
	if is_transitioning:
		return
	for i in range(shuffled_rooms.size()):
		var room_instance = shuffled_rooms[i].instantiate()
		var door = room_instance.find_child(target_door_id, true, false)
		if door:
			room_instance.queue_free()
			is_transitioning = true
			await Hud.fade_out()
			current_index = i
			_load_room_scene(shuffled_rooms[i], target_door_id)
			await Hud.fade_in()
			is_transitioning = false
			return
		room_instance.queue_free()

func _load_room_scene(scene: PackedScene, target_door_id: String):
	if not scene:
		return
	if current_room:
		current_room.queue_free()
		await current_room.tree_exited
	current_room = scene.instantiate()
	add_child(current_room)
	_place_player(target_door_id)

func _place_player(target_door_id: String):
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	var door = current_room.find_child(target_door_id, true, false)
	if door:
		player.global_position = door.global_position
