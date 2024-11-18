extends MarginContainer

@onready var SilverSpinBox: SpinBox = %SpinBox_AmountSilver
@onready var TradeSilverButton: Button = %TradeSilverForLogsButton
@onready var ExchangeRateLogsLabel: Label = %Label_ExchangeRateLogs
@onready var ReceiveLogsLabel: Label = %Label_ReceiveLogs

@onready var LogSpinBox: SpinBox = %SpinBox_AmountLogs
@onready var TradeLogsButton: Button = %TradeLogsForSilverButton
@onready var ExchangeRateSilverLabel: Label = %Label_ExchangeRateSilver
@onready var ReceiveSilverLabel: Label = %Label_ReceiveSilver

func _ready() -> void:
	TradeSilverButton.pressed.connect(_on_trade_silver_button_pressed)
	SilverSpinBox.value_changed.connect(_on_silver_box_changed)
	#ManagerSilver.ref.silver_created.connect(_on_silver_box_changed)
	TradeLogsButton.pressed.connect(_on_trade_logs_button_pressed)
	LogSpinBox.value_changed.connect(_on_logs_box_changed)
	
	_update_labels()
	_update_buttons(0, 0)
	
	_reset_SilverSpinBox()
	_reset_LogSpinBox()

func _on_trade_silver_button_pressed() -> void:
	ManagerMarket.ref.trade_silver_for_logs(SilverSpinBox.value)
	_update_buttons(SilverSpinBox.value, LogSpinBox.value)
	_update_labels()
	_reset_SilverSpinBox()
	
func _on_silver_box_changed(value_silver: float) -> void:
	_update_buttons(value_silver, LogSpinBox.value)
	_update_labels()

func _on_trade_logs_button_pressed() -> void:
	ManagerMarket.ref.trade_logs_for_silver(LogSpinBox.value)
	_update_buttons(SilverSpinBox.value, LogSpinBox.value)
	_update_labels()
	_reset_LogSpinBox()
	
func _on_logs_box_changed(value_logs: float) -> void:
	_update_buttons(SilverSpinBox.value, value_logs)
	_update_labels()

func _update_labels() -> void:
	ExchangeRateLogsLabel.text = "Exchange Rate: %s:1" %ManagerMarket.ref.get_exchange_rate_silver_to_logs()
	ReceiveLogsLabel.text = "Logs to Receive: %s" %ManagerMarket.ref.get_received_logs_preview(int(SilverSpinBox.value))
	ExchangeRateSilverLabel.text = "Exchange Rate: %s:1" %ManagerMarket.ref.get_exchange_rate_logs_to_silver()
	ReceiveSilverLabel.text = "Silver to Receive: %s" %ManagerMarket.ref.get_received_silver_preview(LogSpinBox.value)

func _update_buttons(value_silver: float, value_logs: float) -> void:
	if SilverSpinBox.value >= ManagerMarket.ref.get_exchange_rate_silver_to_logs():
		TradeSilverButton.disabled = !ManagerSilver.ref.can_spend(value_silver)
	else:
		TradeSilverButton.disabled = true
	if LogSpinBox.value >= ManagerMarket.ref.get_exchange_rate_logs_to_silver():
		TradeLogsButton.disabled = !Managerlogs.ref.can_spend(value_logs)
	else:
		TradeLogsButton.disabled = true

func _reset_SilverSpinBox() -> void:
	SilverSpinBox.value = 0

func _reset_LogSpinBox() -> void:
	LogSpinBox.value = 0
