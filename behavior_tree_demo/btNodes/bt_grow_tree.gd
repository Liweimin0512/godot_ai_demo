extends BTLeaf
class_name BTGrowTree

func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("开始种树动作")
	if agent.can_grow_tree():
		var ok : bool = await agent.grow_tree()
		if ok :
			return await completed.emit(succeed())
		else:
			return await completed.emit(fail())
	else:
		return await completed.emit(fail())
