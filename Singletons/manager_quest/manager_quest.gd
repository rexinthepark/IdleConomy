class_name ManagerQuest
extends Node


#region Singleton
static var ref : ManagerQuest

func _init() -> void:
	if not ref: ref = self
	else: queue_free()
#endregion

@onready var _quest01: Quest01 = $Quest01
@onready var _quest02: Quest02 = $Quest02
#@onready var _quest02: Quest02 = $Quest03
#@onready var _quest02: Quest02 = $Quest04
#@onready var _quest02: Quest02 = $Quest05

#not needed (debugger)
#@onready var _tuto_quest_01: TutoQuest01

func _ready() -> void:
	_quest01.completed.connect(_on_quest01_completed)
	_quest02.completed.connect(_on_quest02_completed)

func get_base_quest() -> BaseQuest:
	return $BaseQuest


func get_tuto_quest_01() -> TutoQuest01:
	return $TutoQuest01

func get_quest01() -> Quest01:
	return $Quest01

func get_quest02() -> Quest02:
	return $Quest02

#func get_quest03() -> Quest03:
#	return $Quest03

#func get_quest04() -> Quest04:
#	return $Quest04

#func get_quest05() -> Quest05:
#	return $Quest05

#rewards
#quest01
func _on_quest01_completed() -> void:
	Managerlogs.ref.create_logs(10)
	
func _on_quest02_completed() -> void:
	GeneratorLogs.ref.get_upgrade_02().upgrade_level()
	print("Quest 02 Complete")

func _on_quest03_completed() -> void:
	pass

func _on_quest04_completed() -> void:
	pass

func _on_quest05_completed() -> void:
	pass
