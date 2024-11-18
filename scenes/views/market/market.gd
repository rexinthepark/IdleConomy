extends MarginContainer

@onready var SilverSpinBox: SpinBox = %SpinBox_AmountSilver
@onready var TradeSilverButton: Button = %TradeSilverForLogsButton
@onready var ExchangeRateLogsLabel: Label = %Label_ExchangeRateLogs

func _ready() -> void:
	TradeSilverButton.pressed.connect(_on_trade_silver_button_pressed)
	SilverSpinBox.value_changed.connect(_update_buttons)
	_update_labels()
	_update_buttons(0)

func _on_trade_silver_button_pressed() -> void:
	ManagerMarket.ref.trade_silver_for_logs(int(SilverSpinBox.value))
	_update_buttons(SilverSpinBox.value)

func _update_labels() -> void:
	ExchangeRateLogsLabel.text = "Exchange Rate: %s:1" %ManagerMarket.ref.get_exchange_rate_silver_to_logs()

func _update_buttons(value: float) -> void:
	if SilverSpinBox.value >= ManagerMarket.ref.get_exchange_rate_silver_to_logs():
		TradeSilverButton.disabled = !ManagerSilver.ref.can_spend(value)
	else:
		TradeSilverButton.disabled = true
