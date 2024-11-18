extends Button


@export var logs_to_create : int = 10

func _ready() -> void :
	pressed.connect(_on_pressed)
	text = "Create %s Logs" %logs_to_create

func _on_pressed() -> void :
	Managerlogs.ref.create_logs(logs_to_create)
