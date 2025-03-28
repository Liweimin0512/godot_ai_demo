extends BTLeaf
class_name BTCutTree


func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("开始执行砍树动作")

	if agent.can_cut_tree():
		var ok : bool = await agent.cut_tree()
		if ok :
			return await completed.emit(succeed())
		else:
			return await completed.emit(fail())
	else:
		return await completed.emit(fail())
