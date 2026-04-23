extends Resource
class_name CyoaEvents

@export var image : ImageTexture
@export var description : String
@export var options = Array([], TYPE_STRING, "", null)

func set_cyoa_event(owner_node: Node):
	owner_node.get_node("Panel/VBoxContainer/Label").text = description
	owner_node.get_node("Panel/VBoxContainer/TextureRect").texture = image
	for option in options:
		var button = Button.new()
		button.text = option
		owner_node.get_node("Panel/VBoxContainer/HBoxContainer").add_child(button)
