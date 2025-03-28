extends BTLeaf
class_name BTNeedGrow


func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("判断是否需要种树？")

	if agent.need_grow_tree():
		return await completed.emit(succeed())
	else:
		return await completed.emit(fail())
