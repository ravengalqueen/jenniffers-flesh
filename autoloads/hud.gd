extends CanvasLayer

@onready var interact_hint = $InteractHint
@onready var message_label = $MessageLabel
@onready var fade_rect = $FadeBackground

func show_hint():
	interact_hint.visible = true

func hide_hint():
	interact_hint.visible = false

func display_message(message: String):
	interact_hint.visible = false
	message_label.text = message
	message_label.visible = true
	await get_tree().create_timer(3.0).timeout
	message_label.visible = false
	message_label.text = ""

func fade_out() -> void:
	fade_rect.visible = true
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.5)
	await tween.finished

func fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)
	await tween.finished
	fade_rect.visible = false
