extends Button

@onready var box: HBoxContainer = get_node("%HBoxTradingUpgrades")


func _ready() -> void:
	# Connect the button's pressed signal to a custom method
	pressed.connect(_toggle_upgrade_visibility)
	box.hide()


func _toggle_upgrade_visibility() -> void:
	if box.visible:
		box.hide()
		self.text = "+"
	else:
		box.show()
		self.text = "-"
	
