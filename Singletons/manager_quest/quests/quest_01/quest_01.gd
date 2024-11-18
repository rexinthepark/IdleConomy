class_name Quest01
extends Node
#Quest Logic

signal completed

var _quest_title: String = "Trade for Logs"
var _completion_cost: int = 150
var _completion_resource: String = "Silver" #Silver or Logs


# lock quests with func_is_unlocked
func get_button_text() -> String:
	if is_completed(): return "Completed"
	return "Purchase\n%s : Silver" %_completion_cost

func get_description() -> String:
	return "[center]Someone offers you a good deal on some logs.\
	\nThis might give you a head start.[/center]"

func get_title() -> String:
	var text: String = _quest_title
	if is_completed(): text += " (Completed)"
	return text

func get_purchase_cost() -> int:
	return _completion_cost

func is_hidden() -> bool:
	return false

func is_unlocked() -> bool:
	return true

func is_completed() -> bool:
	return Game.ref.data.progression.quest01_completed

func purchase_completion() -> Error:
	if is_completed(): return FAILED
	if _completion_resource == "Silver":
		if ManagerSilver.ref.spend_silver(_completion_cost) != OK : return FAILED
		Game.ref.data.progression.quest01_completed = true
		completed.emit()
		return OK
	else:
		if Managerlogs.ref.spend_logs(_completion_cost) != OK : return FAILED
		Game.ref.data.progression.quest01_completed = true
		completed.emit()
		return OK
	
