class_name ManagerMarket
extends Node

static var ref : ManagerMarket

func _init() -> void :
	if not ref : ref = self
	else : queue_free()

# signals

#vars
var exchange_rate_silver_to_logs: float = 200 #silver needed to get one log
var exchange_rate_logs_to_silver: float = 0.1 #logs needed to get one silver

#functions

func _ready() -> void:
	pass

func get_exchange_rate_silver_to_logs() -> float:
	return exchange_rate_silver_to_logs

func get_exchange_rate_logs_to_silver() -> float:
	return exchange_rate_logs_to_silver

func get_received_logs_preview(amount: float) -> float:
	var received_logs_preview: float = amount
	received_logs_preview = amount / exchange_rate_silver_to_logs
	return received_logs_preview

func trade_silver_for_logs(amount: float) -> float:
	var traded_logs: float = amount
	traded_logs = amount / exchange_rate_silver_to_logs
	if ManagerSilver.ref.can_spend(amount):
		ManagerSilver.ref.spend_silver(amount)
		Managerlogs.ref.create_logs(traded_logs)
	return traded_logs

func get_received_silver_preview(amount: float) -> float:
	var received_silver_preview: float = amount
	received_silver_preview = amount / exchange_rate_logs_to_silver
	return received_silver_preview

func trade_logs_for_silver(amount: float) -> float:
	var traded_silver: float = amount
	traded_silver = amount / exchange_rate_logs_to_silver
	if Managerlogs.ref.can_spend(amount):
		Managerlogs.ref.spend_logs(amount)
		ManagerSilver.ref.create_silver(traded_silver)
	return traded_silver
