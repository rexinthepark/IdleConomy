class_name ManagerMarket
extends Node

static var ref : ManagerMarket

func _init() -> void :
	if not ref : ref = self
	else : queue_free()

# signals

#vars
var exchange_rate_silver_to_logs: int = 200 #silver needed to get one log

#functions

func _ready() -> void:
	pass

func get_exchange_rate_silver_to_logs() -> int:
	return exchange_rate_silver_to_logs

func get_received_logs_preview(amount: int) -> int:
	var received_logs_preview: int = amount
	received_logs_preview = amount / exchange_rate_silver_to_logs
	return received_logs_preview

func trade_silver_for_logs(amount: int) -> int:
	var traded_logs: int = amount
	traded_logs = amount / exchange_rate_silver_to_logs
	if ManagerSilver.ref.can_spend(amount):
		ManagerSilver.ref.spend_silver(amount)
		Managerlogs.ref.create_logs(traded_logs)
	return traded_logs
