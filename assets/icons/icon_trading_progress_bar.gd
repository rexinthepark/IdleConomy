extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GeneratorSilver.ref.is_active():
		self.value = GeneratorSilver.ref.timer_progress()
