class_name GeneratorLogs
extends Node

static var ref : GeneratorLogs

func _init() -> void :
	if not ref : ref = self
	else : queue_free()



signal generated_logs
signal generator_started
signal generator_stopped

# var _base_generated_logs_per_tick : Vector2i = Vector2i(10, 25)
var _base_generated_logs_per_tick : Vector2i = Vector2i(1, 2)
var _generated_logs_per_tick : Vector2i
var _tick_duration : float = 10
var _tick_and_bonus_duration: float


@onready var _timer : Timer = get_node("Timer")
@onready var _upgrade_01 : LogsGeneratorUpgrade01 = get_node("LogsUpgrade01")
@onready var _upgrade_02 : LogsGeneratorUpgrade02 = get_node("LogsUpgrade02")
#@onready var _pb: TextureProgressBar = get_node("%IconTradingProgressBar")
@onready var percentage_of_time: float

func _ready() -> void:
	_timer.wait_time = _tick_duration
	_timer.timeout.connect(_on_timer_timeout)
	_upgrade_01.leveled_up.connect(_on_upgrade_01_leveled_up)
	_upgrade_02.leveled_up.connect(_on_upgrade_02_leveled_up)
	_calculate_generated_logs_per_tick()


func start() -> void:
	_timer.start()
	generator_started.emit()


func stop() -> void:
	_timer.stop()
	generator_stopped.emit()


func is_active() -> bool:
	return not _timer.is_stopped()


func toggle() -> void:
	if is_active() : stop()
	else : start()

func get_upgrade_01() -> LogsGeneratorUpgrade01 :
	return _upgrade_01

func get_upgrade_02() -> LogsGeneratorUpgrade02 :
	return _upgrade_02

func _generate_logs() -> void:
	var roll : int = randi_range(_generated_logs_per_tick.x, _generated_logs_per_tick.y)
	
	Managerlogs.ref.create_logs(roll)
	generated_logs.emit()
	


func _calculate_generated_logs_per_tick() -> void:
	_generated_logs_per_tick = _base_generated_logs_per_tick + _upgrade_01.get_bonus()


func _on_timer_timeout() -> void:
	_generate_logs()

func _on_upgrade_01_leveled_up() -> void :
	_calculate_generated_logs_per_tick()

func _on_upgrade_02_leveled_up() -> void:
	_calculate_timer_interval()


func _calculate_timer_interval() -> void:
	_tick_and_bonus_duration = _tick_duration - _upgrade_02.get_bonus()
	_timer.wait_time = _tick_and_bonus_duration

func timer_progress() -> float:
	percentage_of_time = ((1 - _timer.time_left / _timer.wait_time) * 100)
	return percentage_of_time