extends MarginContainer
#Quest UI

@onready var _title: Label = %Title
@onready var _description: RichTextLabel = %Description
@onready var _button: Button = %Button

@onready var _quest: BaseQuest = ManagerQuest.ref.get_base_quest()


func _ready() -> void:
	_update_title()
	_update_description()
	_update_button_text()
	_update_button_availability()
	
	_button.pressed.connect(_on_button_pressed)
	_quest.completed.connect(_on_quest_completed)

func _update_title() -> void:
	_title.text = _quest.get_title()

func _update_description() -> void:
	_description.text = _quest.get_description()

func _update_button_text() -> void:
	_button.text = _quest.get_button_text()

func _update_button_availability() -> void:
	if ManagerSilver.ref.can_spend(_quest.get_purchase_cost()):
		if _quest.is_completed():
			_button.disabled = true
		else:
			_button.disabled = false
	else:
		_button.disabled = true


func _on_button_pressed() -> void:
	_quest.purchase_completion()

func _on_quest_completed() -> void:
	_update_title()
	_update_button_text()
	_update_button_availability()
