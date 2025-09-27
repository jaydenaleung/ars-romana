extends CanvasLayer

@export var hide_after: float = 3.0  # seconds until UI hides

func _ready() -> void:
	# Hide after X seconds
	await get_tree().create_timer(hide_after).timeout
	hide()
