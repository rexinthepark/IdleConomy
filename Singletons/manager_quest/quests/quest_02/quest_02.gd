class_name Quest02
extends Node
#Quest Logic

signal completed

var _quest_title: String = "Upgrade your Saw"
var _completion_cost: int = 100
var _completion_resource: String = "Silver" #Silver or Logs


# lock quests with func_is_unlocked
func get_button_text() -> String:
	if is_completed(): return "Completed"
	return "Purchase\n%s : Silver" %_completion_cost

func get_description() -> String:
	return "[center]You can spend some silver to upgrade your saw.\
	\nThis requires the Lumber Camp to be available.[/center]"

func get_title() -> String:
	var text: String = _quest_title
	if is_completed(): text += " (Completed)"
	return text

func get_purchase_cost() -> int:
	return _completion_cost

#couple to progression
func is_hidden() -> bool:
	return false

func is_unlocked() -> bool:
	return true

func is_completed() -> bool:
	return Game.ref.data.progression.quest02_completed

func purchase_completion() -> Error:
	if is_completed(): return FAILED
	if _completion_resource == "Silver":
		if ManagerSilver.ref.spend_silver(_completion_cost) != OK : return FAILED
		Game.ref.data.progression.quest02_completed = true
		completed.emit()
		return OK
	#was else:
	if _completion_resource == "Logs":
		if Managerlogs.ref.spend_logs(_completion_cost) != OK : return FAILED
		Game.ref.data.progression.quest02_completed = true
		completed.emit()
		return OK
	#new:
	else: return FAILED
