extends Control

@export var cyoa_event: CyoaEvents

func _ready():
	if cyoa_event:
		cyoa_event.set_cyoa_event(self)
func show_event(index: int):
	for child in $HBoxContainer.get_children():
		child.queue_free()
		cyoa_event.set_cyoa_event(self)
