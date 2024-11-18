class_name SilverGeneratorUpgrade01
extends Node


signal leveled_up

var _cost : Array[int] = [100, 250, 450]
var _bonus : Array[Vector2i] = [
	Vector2i(1, 2),
	Vector2i(7, 10),
	Vector2i(15, 20),
]

@onready var _max_level : int = _bonus.size()
@onready var data: DataGeneratorSilver = Game.ref.data.generator_silver



func get_cost() -> int:
	if data.upgrade_01_level < 0 or data.upgrade_01_level >= _max_level : return -1
	return _cost[int(data.upgrade_01_level)]

func get_title() -> String:
	var text: String = "Investment Fund"
	if not data.upgrade_01_level: return text
	text += " (%s)" %data.upgrade_01_level
	return text

func get_description() -> String:
	return "Investing your funds with other merchants can allow to increase your profits."


func get_level() -> int:
	return data.upgrade_01_level

func get_max_level() -> int:
	return _max_level

func get_bonus() -> Vector2i:
	if data.upgrade_01_level <= 0 or data.upgrade_01_level > _max_level : return Vector2i(0, 0)
	
	return _bonus[int(data.upgrade_01_level - 1)]


func purchase_level() -> Error:
	if data.upgrade_01_level >= _max_level : return FAILED
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	
	data.upgrade_01_level += 1
	leveled_up.emit()
	
	return OK

func get_is_max_level() -> bool:
	if data.upgrade_01_level == _max_level :
		return true
	else: return false
