extends BTComposite
class_name BTSelector

func run(agent : Node) -> void:
	super(agent)
	run_current_child_node()

func _on_child_completed(result : bool) -> void:
	if result == true:
		current_child_node = 0
		completed.emit(succeed())
		return
	else:
		var ok := run_current_child_node()
		if not ok:
			completed.emit(fail())
			return
