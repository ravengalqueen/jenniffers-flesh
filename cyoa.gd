extends Control

@export var cyoa_event: CyoaEvents

func _ready():
	if cyoa_event:
		print("_ready called")
		cyoa_event.set_cyoa_event(self)
func show_event(index: int):
	print("show_event called with index: ", index)
	for child in $HBoxContainer.get_children():
		child.queue_free()
		cyoa_event.set_cyoa_event(self)
