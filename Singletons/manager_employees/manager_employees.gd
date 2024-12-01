class_name ManagerEmployees
extends Node

static var ref : ManagerEmployees

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
