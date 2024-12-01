class_name Managerlogs
extends Node

static var ref : Managerlogs

func _init() -> void :
	if not ref : ref = self
	else : queue_free()

# Signals
signal logs_updated
signal logs_created(quantity : int)
signal logs_spent(quantity : int)

# Load saved data
@onready var data: Data = Game.ref.data


func get_logs() -> int :
	return Game.ref.data.logs


func create_logs(quantity : int) -> void :
	if quantity <= 0 : return
	
	data.logs += quantity
	
	logs_created.emit(quantity)
	logs_updated.emit()

func can_spend(quantity : int) -> bool :
	if quantity < 0 : return false
	if quantity > data.logs : return false
	return true


func spend_logs(quantity : int) -> Error :
	if quantity < 0 : return Error.FAILED
	if quantity > data.logs : return Error.FAILED
	
	data.logs -= quantity
	
	logs_spent.emit(quantity)
	logs_updated.emit()
		
	return Error.OK
