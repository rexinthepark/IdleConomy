class_name ButtonCollapse
extends Button


@export var _target: Control


func _ready() -> void:
	pressed.connect(_on_pressed)
	text = "+"
	_target.visible = false


func _on_pressed() -> void:
	_toggle_collapse()

func _toggle_collapse() -> void:
	if _target.visible:
		text = "+"
		_target.visible = false
	else:
		text = "-"
		_target.visible = true