class_name Data
extends Resource

@export var silver: int
@export var logs: int

@export var generator_silver: DataGeneratorSilver
@export var generator_logs: DataGeneratorLogs

@export var progression: DataProgression

func _init() -> void:
	silver = 0
	logs = 0
	
	generator_silver = DataGeneratorSilver.new()
	generator_logs = DataGeneratorLogs.new()
	progression = DataProgression.new()
