extends Label


func _ready() -> void :
	_update_text()
	Managerlogs.ref.logs_updated.connect(_on_logs_updated)

func _update_text() -> void :
	text = "Logs: %s" %Managerlogs.ref.get_logs()


func _on_logs_updated() -> void :
	_update_text()
