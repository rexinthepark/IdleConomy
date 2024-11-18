class_name SilverGeneratorUpgrade02
extends Node


signal leveled_up

var _cost : Array[int] = [100, 300, 500, 1000]
var _bonus : Array[float] = [
	float(0.5),
	float(0.75),
	float(1),
	float(1.5),
]

@onready var _max_level : int = _bonus.size()
@onready var data: DataGeneratorSilver = Game.ref.data.generator_silver


func get_title() -> String:
	var text: String = "Networking"
	if not data.upgrade_02_level: return text
	text += " (%s)" %data.upgrade_02_level
	return text
	
func get_description() -> String:
	return "A few connections will help you find clients faster."

func get_cost() -> int:
	if data.upgrade_02_level < 0 or data.upgrade_02_level >= _max_level : return -1
	
	return _cost[int(data.upgrade_02_level)]

func get_level() -> int:
	return data.upgrade_02_level

func get_max_level() -> int:
	return _max_level

# change to timer change
func get_bonus() -> float:
	if data.upgrade_02_level <= 0 or data.upgrade_02_level > _max_level : return float(0)
	
	return _bonus[int(data.upgrade_02_level - 1)]


func purchase_level() -> Error:
	if data.upgrade_02_level >= _max_level : return FAILED
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	
	upgrade_level()
	
	return OK

func upgrade_level() -> void:
	data.upgrade_02_level += 1
	leveled_up.emit()

func get_is_max_level() -> bool:
	if data.upgrade_02_level == _max_level :
		return true
	else: return false
