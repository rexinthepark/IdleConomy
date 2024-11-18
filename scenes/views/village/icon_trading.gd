extends TextureRect

var _is_critical: bool = false

func _ready() -> void :
	ManagerSilver.ref.silver_created.connect(_show_resource_number)




func _show_resource_number(quantity: int) -> void:
	
	if UserInterface.ref.active_view() == 0:
		if quantity >= 25:
			_is_critical = true
		ResourceNumbers.display_number(quantity, self.global_position, _is_critical)
		_is_critical = false
	
	
