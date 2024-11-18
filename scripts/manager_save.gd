class_name ManagerSave

#const SHOULD LOAD SET TO FALSE!
const SAVE_PATH: String = "user://save.tres"
const SHOULD_LOAD: bool = false

static func save_data() -> void:
	ResourceSaver.save(Game.ref.data, SAVE_PATH)
	print("Data Saved")

static func load_data() -> void:
	if not SHOULD_LOAD: return
	if not ResourceLoader.exists(SAVE_PATH): return
	Game.ref.data = load(SAVE_PATH)
	#Game.ref.data = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CacheMode.CACHE_MODE_IGNORE)
	print("Data loaded")
	
static func clear_data() -> void:
	pass
