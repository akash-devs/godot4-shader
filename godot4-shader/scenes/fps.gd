extends Label3D

func _process(_delta: float) -> void:
	# Engine.get_frames_per_second() grabs the raw live hardware frame rate
	var current_fps = Engine.get_frames_per_second()
	
	# update the text on screen instantly
	text = "FPS: " + str(current_fps)
